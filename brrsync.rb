# frozen_string_literal: true

module Nanoc::Deploying::Deployers
  # A deployer that deploys a site using rsync.
  #
  # The configuration has should include a `:dst` value, a string containing
  # the destination to where rsync should upload its data. It will likely be
  # in `host:path` format. It should not end with a slash. For example,
  # `"example.com:/var/www/sites/mysite/html"`.
  #
  # @example A deployment configuration with public and staging configurations
  #
  #   deploy:
  #     public:
  #       kind: brrsync
  #       dst: "ectype:sites/stoneship/public"
  #     staging:
  #       kind: rsync
  #       dst: "ectype:sites/stoneship-staging/public"
  #       options: [ "-glpPrtvz" ]
  #       broptions: [ "--quality 11" ]
  #
  # @api private
  class BrotliRsync < ::Nanoc::Deploying::Deployer
    identifier :brrsync

    # Default rsync options
    DEFAULT_OPTIONS = [
      '--group',
      '--links',
      '--perms',
      '--partial',
      '--progress',
      '--recursive',
      '--times',
      '--verbose',
      '--compress',
      '--exclude=".hg"',
      '--exclude=".svn"',
      '--exclude=".git"',
    ].freeze

    # Default brotli options
    DEFAULT_BROTLI_OPTIONS = [
      '--quality=11',
      '--force',
    ].freeze

    # @see Nanoc::Deploying::Deployer#run
    def run
      # Get params
      src = source_path + '/'
      dst = config[:dst]
      options = config[:options] || DEFAULT_OPTIONS
      broptions = config[:broptions] || DEFAULT_BROTLI_OPTIONS
      
      # Validate
      raise 'No dst found in deployment configuration' if dst.nil?
      raise 'dst requires no trailing slash' if dst[-1, 1] == '/'

      # Run
      if dry_run
        warn 'Performing a dry-run; no actions will actually be performed'
        run_recursive_shell_cmd(src, ['echo', 'brotli', broptions].flatten)
        run_shell_cmd(['echo', 'rsync', options, src, dst].flatten)
      else
        run_recursive_shell_cmd(src, ['brotli', broptions].flatten)
        run_shell_cmd(['rsync', options, src, dst].flatten)
      end
    end

    private

    def run_shell_cmd(cmd)
      TTY::Command.new(printer: :null).run(*cmd)
    end

    def run_recursive_shell_cmd( directory, cmd )
      files = `find #{directory} -type f -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.svg' -o -name '*.png'`
      files.split("\n").each do |file|
        realcmd = cmd +
                  [ file,
                    "--output=#{file}.br",
                  ]
        run_shell_cmd(realcmd) 
      end
    end
  end
end
