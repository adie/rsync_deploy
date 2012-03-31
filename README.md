Rsync Deploy
============

Simple deploy tool that is using rsync

You need to create a config file named `rsync_deploy.rb` in the root of your project with contents:

``` ruby
set :deploy_to, "user@host.com:/path/to/project"
set :targets, %w(
  first/directory
  second/directory
)
```

Then just run `rsync_deploy` and it will sync your targets

