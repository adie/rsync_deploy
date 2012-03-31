require 'rubygems'
require 'colorize'
require 'shell-spinner'

module RsyncDeploy
  class Runner
    def self.run(config = nil)
      config = RsyncDeploy::Config.new(config || 'rsync_deploy.rb')

      rsync = "rsync -r -v --progress --delete -c -z -s"
      rsync_dry_run = rsync + " -n"

      updated = []

      puts "Dry run first!".bold.green

      config.targets.each do |target|
        result = nil
        ShellSpinner "checking #{target}".green do
          result = `#{rsync_dry_run} #{target} #{config.deploy_to}/#{target}`
        end
        if result.lines.count > 4
          updated << target
          puts "!".bold.red + " Updated files:".bold.blue
          puts result.split("\n")[1..-4]
        end
      end

      if updated.empty?
        puts "~ Everything is up to date! Nothing to do!".bold.green
      else
        print "\nIs it ok to deploy? [y/n]: ".bold.green
        system "stty raw -echo"
        yesno = STDIN.getc
        system "stty -raw -echo"
        puts

        if yesno.downcase == 'y'
          updated.each do |target|
            system "#{rsync} #{target} #{config.deploy_to}/#{target}"
          end
          puts "~ Done!".bold.green
        else
          puts "~ Finished".bold.green
        end
      end
    rescue RsyncDeploy::Config::MissingConfigError => e
      puts "Error: ".bold.red + e.message
    end
  end
end

