# ironic-packer-template-windows2016

[Packer](https://www.packer.io/) template for Windows Server 2016, capable of Ansible provisioning behind a proxy. Simple playbook for updating proxy settings has been provided. Optimized for building qcow2 images for Ironic using QEMU.

## Usage

Build (if you already have Virtio ISO):

	$ packer build -only=qemu .\ubuntu1804.json

Or (downloads Virtio ISO and executes build):
  $ ./build.sh

## Notes
This template has been created in order to resolve problems with provisioning Windows Server 2016 behind a proxy. Keep in mind that:
- For shell provisioners and propagation of proxy settings, use:
```
"environment_vars": [
    "FTP_PROXY={{ user `ftp_proxy` }}",
    "HTTPS_PROXY={{ user `https_proxy` }}",
    "HTTP_PROXY={{ user `http_proxy` }}",
    "NO_PROXY={{ user `no_proxy` }}",
    "ftp_proxy={{ user `ftp_proxy` }}",
    "http_proxy={{ user `http_proxy` }}",
    "https_proxy={{ user `https_proxy` }}",
    "no_proxy={{ user `no_proxy` }}"
  ]
```
- For ansible-local provisioner use:
```
"extra_arguments": [
    "--extra-vars",
    "{'\"http_proxy\":\"{{ user `http_proxy` }}\", \"https_proxy\":\"{{ user `https_proxy` }}\", \"no_proxy\":\"{{ user `no_proxy` }}\", \"ftp_proxy\":\"{{ user `ftp_proxy` }}\"}'"
  ]
  ```
Then handle these variables appropriately in playbook, set environment variables, etc.
- In case of ansible-local there are problems when specifying inventory_groups: even though connection type passed to ansible is "local", it gets ignored and regular SSH connection is used. This causes problems due to unauthorized key for passwordless login to localhost. As a workaround you have to specify inventory_file with ansible_connection specified explicitly, for example:
```
[windows]
127.0.0.1 ansible_connection=local
```

*Note: tested with Ansible 2.6.1*
