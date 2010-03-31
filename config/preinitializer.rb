#
# Add these GEM vars to the environment so Ruby can find the local gems.
# This is an optional file added to allow for local gems on the shared host.
# note that the same env vars are set in .bashrc.  However /usr/bin/ruby doesnt execute in a bash...
#
# file added 1/12/2010 LKANG
#
ENV['GEM_HOME']="/home/lkang/.gem/ruby/1.8"
ENV['GEM_PATH']="/home/lkang/.gem/ruby/1.8:/var/lib/gems/1.8"



