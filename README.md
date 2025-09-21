## NixOS Plymouth

A plymouth theme for NixOS that fades into the NixOS logo.

1. Generate NixOS Logo from branding repo
2. Edit in inkscape
   1. Add background layer and center on page
   2. Group logo and center in background layer
   3. Duplicate logo group and set blur to 15%
   4. Duplicate logo and set blur to 30%
   5. Rename groups to logo, blur 1 and blur 2 respectively
3. Animate in xyris.app
   1. Create Fade In animation
      1. Set both blur groups opacity to 0
      2. Animate logo opacity
      3. Set keyframe at position 0 with opacity 0
      4. Set key frame at 5s with opacity 100
      5. Set animation to ease in
      6. Export as mp4
   2. Create pulse animation
      1. Set logo opacity to 100 and both blurs to 100
      2. Animate both blurs
      3. Set keyframe at the following positions with the following opacities for both blurs
         1. 0s 0%
         2. 2.5s 100%
         3. 3s   100%
         4. 5.5s 0%
         5. 6s   0%
      4. Set ease in to all transitions
      5. Export as mp4
4. Convert fade in to image series
   2.

nix-shell -p nodejs ungoogled-chromium

export PUPPETEER_EXECUTABLE_PATH=$(which chromium)
export PUPPETEER_SKIP_DOWNLOAD=true
npm install puppeteer

node render-svg-frames.js '../../resources/nixos-logo-animated.svg'

ffmpeg -i ./nixos-boot-logo-pulse.mp4 -vf fps=60 ../src/resources/animation-%03d.png -hide_banner

**`sudo plymouthd ; sudo plymouth --show-splash ; sleep 10 ; sudo killall plymouthd`
**

**Warning: Using this repo for some reason bloats the `initrd` quite a bit (up to 50 MB). Use it with [boot.loader.systemd-boot.configurationLimit](https://search.nixos.org/options?channel=23.05&show=boot.loader.systemd-boot.configurationLimit&from=0&size=50&sort=relevance&type=packages&query=systemd-boot) or a `/boot` of at least a gigabyte.
On EFI Systems it's also possible to keep the initrd on the main partition when switching to Grub. Checkout the [nixos wiki](https://wiki.nixos.org/wiki/Bootloader#Keeping_kernels/initrd_on_the_main_partition).**

This repo contains a plymouth theme for Nixos, thanks to [discourse](https://discourse.nixos.org/t/genix7000-nix-project-logo-generator/15937/9) for giving me motivation.

# Install

The package is currently not in nixpkgs.

## Flakes

You can include it in your `flakes.nix` like this:

```nix
{
  inputs.nixos-boot.url = "github:Melkor333/nixos-boot";
  outputs = { self, nixpkgs, nixos-boot }:
  {
    nixosConfigurations."<hostname>" = nixpkgs.lib.nixosSystem {
      modules = [ nixos-boot.nixosModules.default ./configuration.nix ];
      system  = "x86_64-linux";
    };
  };
}

```

## Non Flakes

You can include it in your `configuration.nix` like this:

```nix
{ config, lib, pkgs, ...}:
let
  # Fetch the repository
  nixos-boot-src = pkgs.fetchFromGitHub {
    owner = "Melkor333";
    repo = "nixos-boot";
    rev = "main";
    sha256 = "sha256-Dj8LhVTOrHEnqgONbCEKIEyglO7zQej+KS08faO9NJk=";
  };
in
{
  imports = [ "${nixos-boot-src}/modules.nix" ];
}
```

## Configuration

Enable nixos-boot in your configuration:

```nix
{ config, lib, pkgs, ...}:
{
  # ...
  nixos-boot = {
    enable  = true;

    # Different colors
    # bgColor.red   = 100; # 0 - 255
    # bgColor.green = 100; # 0 - 255
    # bgColor.blue  = 100; # 0 - 255

    # If you want to make sure the theme is seen when your computer starts too fast
    # duration = 3; # in seconds
  };
}
```

# Themes

## load_unload

The first theme, load & unload:

![nixos logo loading and unloading](./src/load_unload.gif)

## evil-nixos

The second theme, a spinning logo looking a bit communistic:

![nixos logo with communist colors](./src/evil-nixos.png)

# Adding new themes

- Create directory under src
- Copy all files as .png in there
- copy the `src/template.plymouth` to `src/THEME/THEME.plymouth`

  - replace the word THEME with the actual theme
  - adjust the description & Comment
- copy the `src/template.script` to `src/THEME/THEME.script`

  - change the line "image_quantity" to match the amount of pictures
  - Create a gif from the pngs in the folder:

  ```shell-session
  magick convert -delay 5 -loop 0 -background white $(ls -v *.png) -alpha remove THEME.gif
  ```
- Add the new entry to `modules.nix`

  ```nix
  type = lib.types.enum [ "load_unload" "evil-nixos" "THEME" ];
  ```
- Create a Readme Entry




# NixOs-Plymouth

This an awesome, sophisticated and minimalist Plymouth Theme.

## Prerequisites

In order to use this theme, you need to install and configure Plymouth application to show a graphical boot animation while the boot process happens in the background. To achieve this run these commands:

```bash
$ sudo apt install plymouth plymouth-themes
```

And configure Plymouth for your graphic card, editing the file `/etc/initramfs-tools/modules` and adding these modesetting lines:

* **For Intel Graphic Cards:**
  ```ini
  # KMS
  intel_agp
  drm
  i915 modeset=1
  ```
* **For NVidia Graphic Cards:**
  ```ini
  # KMS
  drm
  nouveau modeset=1
  ```
* **For ATI Graphic Cards:**
  ```ini
  # KMS
  drm
  radeon modeset=1
  ```

## How to install it?

Follow this instructions from a Terminal:

1. Copy `darwin` folder to path `/usr/share/plymouth/themes/`:

   ```bash
   $ sudo cp -R darwin/ /usr/share/plymouth/themes/
   ```
2. Install it running these commands:

   ```bash
   $ sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/darwin/darwin.plymouth 100

   $ sudo update-alternatives --config default.plymouth
   ```

   And choose the plymouth theme number, then press Enter key
3. Activate it running this command:

   ```bash
   $ sudo update-initramfs -u
   ```


## Credits

* Creating Glows in SVGs - www.youtube.com/watch?v=oe8RB4Y6Vi4
* https://github.com/Melkor333/nixos-boot
* https://github.com/helsinki-systems/plymouth-theme-nixos-bgrt
* https://github.com/vikashraghavan/dotLock
