# Garuda Linux server configurations

Hello and welcome to the repo managing our infrastructure. Lets have a look at how it all works:

- Ansible is used to have reproducable environments and sets up the base system for Docker
- Docker & docker-compose is used to setup the applications and webservices

## This repo

- GitLab CI is setup and ready to be used, it currently responds to two keywords:
  - Changes can be automatically tested by supplying `dry-run` together with the name of the playbook to run, eg `Somechange, dry-run full_run.yml`
  - Deploying is also possible by supplying `deploy` together with the name of the playbook to run, eg `Somechange [deploy full_run.yml]`

## Ansible

- We have different roles for all parts of the infrastructure
- Environment variables are contained in the `host_vars` folders, split regular and encrypted files in case of sensible data
- Supplying the `ansible-vault` password is done in `ansible/.vault_pass` - this file needs to exist in order to run playbooks
- For a complete server setup, the `full-run.yml` playbook should be used
- Updating all systems & rebooting them can be done by running the `system-update.yml` and `reboot.yml` playbooks

### Common

- Sets up everything needed for on all servers, eg. Pacman configurations, `motd` or `systemd-oomd`

### Hardening

- Server hardening is done using the [Devsec Hardening framework](https://github.com/dev-sec/ansible-collection-hardening)
- We use the `os_hardening` and `ssh_hardening` playbooks, other services don't benefit from this as we run all the stuff inside of containers
- Individual settings can be put into `host_vars` in case of specific needs

### Borg Clients

- To add automatic backups to a server, add it `[borg-clients]` in the `hosts` file and specify the `borg_dir` variable, eg. `borg_dir="/var/cache/garuda-web"`
- The SSH key of the root user then needs to be added to the borg servers `authorized_keys`
- Do a test run in order to add the borg server to `known_hosts`

### Chaotic-AUR

- The Chaotic-AUR role is supposed to bootstrap a basic Chaotic-AUR build environment. It is maintained at the Chaotic-AUR GitHub org and added as submodule, therefore don't forget to initialize it!
- It also creates a GPG key if it doesn't exist and fetches it to `ansible/buffer`
- The content of `chaotic.conf` can be defined in `host_vars`, these also control whether a cluster node or primary node is being deployed
- If the primary node is managed by Ansible (`caur_primary = true`), SSH keys are automatically added to its `authorized_keys`
- Make sure to add the required `host_vars`, examples can be found in `ansible/roles/chaotic_aur/defaults/main.yml`
- If `caur_mirror` is set to `true`, a local Syncthing mirror and web server will be deployed as well

### Users_sudo

- In this role we specify our users and their permissions
- To add a user simply add it to the array of users - groups can also be passed here
- There are three types of users: regular, admins and Chaotic-AUR maintainers - the latter gets added when the host is added to the `[chaotic_aur]` group

### Letsencrypt

- Used to detect Letsencrypt instances based on the `letsencrypt` variable
- Can also update certificates if needed
- Needs `letsencrypt_domain` and `letsencrypt_data` specified as `host_vars`

### Systemd

- Contains various Systemd units needed on certain systems
- Can be controlled by specifying environment variables in `host_vars`

### How it is connected

<img src="https://gitlab.com/garuda-linux/infrastructure/-/raw/main/Infra.png" alt="Infra structure">

## Docker

- The uppercase directories in the main directory represent our individual servers
- The `docker-compose.yml.j2` files (`ansible/roles/docker_compose/templates`) in conjunction with static configuration files can be altered and pushed to the servers using the `garuda.yml` playbook
- Environment variables are passed via `host_vars`, replace them with {{ ansible_env_vars }} inside of the `docker-compose.yml.j2` files
- Put sensible environment variables inside of the `host_vars` folder, here we have `*_vault.yml` files which are encrypted

## Linting

- We use `prettify` In order to achieve a consistent code style and formatting
- Install yarn und run `yarn install` inside the project directory to set up the its dependencies
- `yarn run lint` will run the linter and show the results, `yarn run prettify` will fix the found issues
