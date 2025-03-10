# Configuration

Open the [tools container](../../concepts/tools-container.md), which includes all the tools needed:

=== "Docker"

    ```sh
    make tools
    ```

=== "Nix"

    ```sh
    nix develop
    ```

!!! note

     It will take a while to build the tools container on the first time

Run the following script to configure the homelab:

```sh
make configure
```

!!! example

    <!-- TODO update example input -->

    ```
    Text editor (nvim):
    Enter seed repo (github.com/fullstackjam/k8s-gitops): github.com/example/k8s-gitops
    Enter your domain (fullstackjam.com): example.com
    ```

It will prompt you to edit the inventory:

- IP address: the desired one, not the current one, since your servers have no operating system installed yet
- Disk: based on `/dev/$DISK`, in my case it's `sda`, but yours can be `sdb`, `nvme0n1`...
- Network interface: usually it's `eth0`, mine is `eno1`
- MAC address: the **lowercase, colon separated** MAC address of the above network interface


At the end it will show what has changed. After examining the diff, commit and push the changes.
