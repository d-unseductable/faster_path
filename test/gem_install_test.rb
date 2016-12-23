require 'test_helper'
#require 'bundler/cli'
require 'fileutils' 
require 'rubygems'
require 'rubygems/package'
require 'rubygems/installer_test_case'


# Gem::Installer.at
# - https://github.com/rubygems/rubygems/blob/master/lib/rubygems/installer_test_case.rb#L192-L196
# - https://github.com/rubygems/rubygems/blob/master/lib/rubygems/installer.rb#L101-L105
#
# Construct an installer object for an ephemeral gem (no .gem, only .gemspec)
# - https://github.com/rubygems/rubygems/blob/master/lib/rubygems/installer.rb#L133-L136
#
# Create .gem from .gemspec
# - https://github.com/rubygems/rubygems/blob/master/lib/rubygems/package.rb
#
# Gem.instance_variable_get :@default_dir
# # => "/home/danielpclark/.rvm/rubies/ruby-2.3.1/lib/ruby/gems/2.3.0"
# Gem.instance_variable_get :@ruby_api_version
# # => "2.3.0"


class GemInstallTest < Gem::InstallerTestCase
  def setup
    super
    common_installer_setup

    #if __name__ =~ /^test_install(_|$)/ then
    #  FileUtils.rm_r @spec.gem_dir
    #  FileUtils.rm_r @user_spec.gem_dir
    #end

    @config = Gem.configuration
  end

  def teardown
    common_installer_teardown
    Dir.chdir(Pathname('__FILE__').parent.parent)
  end

  def test_compiles_the_extension
    #skip 'WIP'
    
    stars = "*" * 30
    ######################
    # BUILD GEM
    gemspec = 'faster_path.gemspec'
    @spec = eval IO.read( File.join(File.expand_path(Pathname(__FILE__).parent.parent), gemspec) )

    @installer.gem_dir = @spec.gem_dir

    gemfile = "#{@spec.name}-#{@spec.version}.gem"
    Gem::Package.build @spec
    _(Dir.entries('.')).must_include gemfile, "Current directory does not include gem"
    #######################
    puts "\n" + stars
    
    ########################
    
    faster_path_gem = File.expand_path(Pathname(__FILE__).parent.parent)
    puts stars
    puts "The faster_path_gem path is #{faster_path_gem}"
    _(Dir.entries(faster_path_gem)).must_include gemfile, "Current path does not include gem"
    
    ########################

    #Dir.mktmpdir('build_test') do |tempdir|
    #  Dir.chdir(tempdir) do
    #    puts "Changed into #{tempdir} directory"

    #    puts "Assigning temporary directory with Gem.use_paths"
    #    Gem.use_paths(tempdir)

    #    puts "Clear unresolved deps"
    #    Gem::Specification.unresolved_deps.clear

    #    puts "Ensure directory exists"
    #    Gem.ensure_gem_subdirectories(tempdir)

    #    # Don't know if this is needed
    #    Gem::RemoteFetcher.fetcher = Gem::FakeFetcher.new

    #    puts "Initializing installer for gemspec"
    #    @installer = Gem::Installer.at(@spec, install_dir: tempdir)
    #    puts "Done initializing installer for gemspec"
    #           
    #    puts stars
    #    puts "Testing directory results"
    #    _(Dir.entries(tempdir)).must_include 'target'
    #    _(Dir.entries(tempdir + 'target')).must_include 'release'
    #    _(Dir.entries(tempdir + 'target/release').keep_if {|i| i['faster_path']}).must_be :one?
    #  end
    #end
  end
end









        #File.write(dir + '/Gemfile', <<-GEMFILE)
        #  source 'https://rubygems.org'
        #  gem 'faster_path', path: '#{faster_path_gem}'
        #GEMFILE
        #_(File).must_be :exist?, dir + '/Gemfile'
        #puts stars
        #puts "Made Gemfile with the following content"
        #puts File.read(dir + '/Gemfile')
        #vendor = Pathname(dir) 
  ###########
  # Set Gem install dir
  #Gem.default_dir = vendor
  ###########


        #puts stars
        #puts "Assigning a vendor path as #{vendor}"
        #FileUtils::mkdir_p vendor
        #puts "Making that directory"
        #puts "Starting bundle..."
        # Bundler.clean_system()

               #########################################
               #Gem.bin_path('bundler', 'bundle'), 'install',
               ##'--gemfile', faster_path_gem.+('../faster_path.gemspec').to_s,
               #'--path', vendor.to_s,
               #'--standalone',
               #'--verbose'
 
#system(#{'GIT_DIR' => faster_path_gem.+('../.git').to_s},
#       #{
#       #  #'BUNDLE_GEMFILE' => tempdir + '/Gemfile',
#       #  'BUNDLE_PATH' => tempdir.to_s,
#       #  'GEM_HOME' => tempdir.to_s
#       #},
#       
#       Gem.bin_path('rubygems', 'gem'), 'install',
#       '--local', Pathname(faster_path_gem) + gemfile,
#       '--install-dir', Pathname(tempdir) + 'vendor/bundle'
#     )
