# termux-nextcloud-notificator
A simple termux script to send a notifications form your Nextcloud server in case if you don't have Nextcloud app or Google play services
## Installing
To install this program you should have following apps installed [Termux](https://termux.com), Termux:Boot, Termux:API.<br>
Open termux and install `git` command:<br>
```
$ pkg install git debianutils vim
```

Clone the code

```
$ git clone https://github.com/Andrewerr/termux-nextcloud-notificator
$ cd termux-nextcloud-notificator
```

Run `install.sh` script:<br>
```
$ ./install.sh all
```
Now you need to configure the program. There is two ways to do this:
* Using `vim`: `./install.sh configure`
* Using `nano`/`emacs`/...: `your-editor /data/data/com.termux/files/usr/etc/nextcloud-notificator.yml`
The config files is as follows
```
# Manually-written configuration for Nextcloud notification poller
cloud:
  endpoint: "cloud.example.com" # Domain of your Nextcloud
  user: "user" # You username in Nextcloud
...
```
<br>
So here you should set following two variables `endpoint` and `user`:
* `endpoint` is domain of you cloud
* `user` your username at your server
After this it is recommend to do first run(On boot authorization may not open). So just run:
```
$ ./run.rb
```
So now you should authorize at your cloud.

## Managing installation
`./install.sh` has few more options:
* `update` - updates your installation to latest **development** release
* `deauth` - removes your authentication credentials(Maybe useful in case of 401 error)
