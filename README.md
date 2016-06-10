#### Ansible playbooks for setting up Ubuntu-based WordPress host(s)

# Includes:

* changing shell to zsh
* installing Oh-My-Zsh
* installs rvm with MRI Ruby and JRuby (which also installs Java (JDK))


# Instructions:

* Ensure you have ssh access without password (i.e. you have added the public key to root's .ssh/authorized_keys).
* ansible-playbook 01*.yml
* ansible-playbook 02*.yml
* Add the following line using visudo: deploy  ALL=(ALL) NOPASSWD:ALL
* Log in to root using ssh, then reboot (to eliminate "Please log into your droplet via SSH to enable your WordPress installation." message).
* Log on to WordPress site to install it (e.g.: http://128.199.150.150/).
* "You are encouraged to run mysql_secure_installation to ready your server for production."
* Manually run: sudo apt-get install phpmyadmin
* Add this line to .zshrc to get host name in prompt: export PS1="`hostname`: $PS1"
* Add public key to github to be able to git clone repos.


