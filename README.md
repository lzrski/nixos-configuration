# Configuration for NixOS

This brbnch contains (hopefully working) configuration for NixOS on my MacBook Pro 2015.

There may be other branches for other configurations.

## Status:

I would say it's usable as a development machine. Some things I'm still figuring out. Here's a list:

  - [x] Boots up

  - [x] Graphical UI

    I3 with dual monitor, but it's mostly thanks to [dotfiles][].


  - [x] Magic Trackpad

    Basically works, including two fingers natural scrolling. Gestures doesn't work but I don't miss them that much.

  - [x] Networking

    Using Network Manager. The only problem is that WiFi passwords are not stored, but this is probably to be fixed in [dotfiles][].

  - [x] Bluetooth speaker

    This was a little bit of a challange, but finally got it working with PulsAudio and `bluetoothctl`. The part I was missing for a whilte was:

    ```nix
    { # ...
      hardware.pulseaudio.package = pkgs.pulseaudioFull;
    }
    ```

  - [ ] Facetime HD webcam

    I got it partially working (only with Cheese), but only with propriatary driver and the video quality was aweful. Disabled for now and liekly for ever.

  - [ ] LXC / LXD containers

  - [ ] Latest version of Atom editor

    Latest is 1.18 as of writing this. Installed is 1.16. There is a nice git integration there, so I want it :)

  - [ ] Graphical greeter

    I'm using SSDM and it's mostly working, but with dual screen I have very weird overlaping of the displays. Hard to explain without a screenshot, but basically looks like shit.

[DotFiles]: https://github.com/lzrski/dotfiles
