
# What

Script(s) to install Mountebank on an Ubuntu server. Tests using test-kitchen and a docker provider.


# Why

I want to use this with example infrastructure projects. It can be used to set up test fixtures to automatically test infrastructure, and also to demonstrate application deployment patterns.


# How

TODO: Instructions and example for running this script on an AWS EC2 instance using cloud-init, from Terraform.


## Testing

To set up for testing on my Mac I run `brew cask install docker`, then `open --background -a Docker` to make sure the daemon is running. Then:

```console
kitchen create
kitchen converge
kitchen setup
kitchen verify
kitchen destroy
```

