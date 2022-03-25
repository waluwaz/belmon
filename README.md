# modmon
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/91af8db9cd354643a8ef6a7117be90fb)](https://www.codacy.com/app/waluwaz/modmon?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=waluwaz/modmon&amp;utm_campaign=Badge_Grade)
![Shellcheck](https://github.com/waluwaz/modmon/actions/workflows/shellcheck.yml/badge.svg)

## v0.4.0-beta
### Updated on 2022-03-25
## About
modmon is a tool that tracks your cable modem's stats (such as signal power levels) for AsusWRT Merlin with charts for daily, weekly and monthly summaries. It was created by JackYaz. 
This repository has a derivative work based on modmon and customized to work with another modem, the Technicolor CGA4233 from VOO in Belgium. It doesn't have a specific name, because I'm not sure how to change the name without breaking it   ;-)  ; also because it probably couldn't coexist with the original modmon, and finally because I can't imagine a scenario where someone would concurrently need the original modmon and my hack as I'm not aware anyone in Belgium (or anywhere else) would have the option to use the target modem of this and the target modem of the original modmon.

So, my work tries to support the Technicolor CGA4233 from VOO in Belgium. Compared to the version of Jack, it hammers the modem every 15 minutes. It possibly needs you to update the curl command around line 815 and 1044 of modmon in /jffs/scripts, and paste the tokens for PHP session and authentication (also in CSRF). I got them with F12 (Developer tools)/Network/Reload/Copy as curl while accessing the VOO webui. (If this is completely mysterious to you, this beta software might not be a satisfying experience for you.) 

modmon voo is free to use under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0) (GPL 3.0).

If you have yet another modem, you can also look at the branch https://github.com/waluwaz/modmon/tree/Example-of-minimum-changes-for-new-modem-support (or version 0.1 in master). It's an example of a simple dirty approach at supporting another modem, roguely sticking new metrics in the original 6 metrics of modmon.
Since version 0.2, this is customized to use its own framework of 7 metrics, in line with what's available from the VOO modem.

### Supporting development
Love the script ? Any and all donations gratefully sent to JackYaz who did 100% of the work for the original modmon, which means 95% of the work for this. For more reliability, please navigate to Jack's repo and click Paypal from his repo. If you insist on supporting "me", please do send the money to your favourite charity.

## Recommended firmware versions
You must be running firmware Merlin 384.15/384.13_4 or Fork 43E5 (or later) [Asuswrt-Merlin](https://www.asuswrt-merlin.net/)

## Installation
WARNING: 
This addon doesn't have a community of testers. I don't have the skills of regular addon writers. Use at your own risk.
If you don't have a backup router, remember that you're risking the stability of a critical piece of your infrastructure, with mostly unsupported/untested software. 
Moreover, information might be power, but the addon is unlikely to inform you of anything that you will have direct control on.
Indirectly, charts and figures might help you convincing your ISP to seriously adress issues though, if you do experience issues (e.g. excessive packet drops).

If you do have the original modmon, installing this will wipe the original modmon file in /jffs/scripts and .asp file in /jffs/addons/modmon.d. It will also add tables in the database. It will replace the original both for the commond-line interface, and in the webUI.

So, if you still want to install...

Using your preferred SSH client/terminal, copy and paste the following command, then press Enter:

```sh
/usr/sbin/curl --retry 3 "https://raw.githubusercontent.com/waluwaz/modmon/master/modmon.sh" -o "/jffs/scripts/modmon" && chmod 0755 /jffs/scripts/modmon && /jffs/scripts/modmon install
```

If it doesn't work, consider adapting the script to an active session. See above. This modification might have to be renewed, e.g. if the modem reboots for instance. If it still doesn't work, you could test another add-on from JackYaz. There might be some prerequisites that I forgot to mention.

## Usage
### WebUI
modmon can be configured via the WebUI, in the Addons section. I recommend you use USB and not JFFS, in those settings. See the statement from RMerlin at https://github.com/RMerl/asuswrt-merlin.ng/wiki/JFFS.

### Command Line
To launch the modmon menu after installation, use:
```sh
modmon
```

If this does not work, you will need to use the full path:
```sh
/jffs/scripts/modmon
```

## Screenshots
See Jack's repo for a  flavour of the UI. Except that the 7 metrics here are a bit different from the 6 metrics in the original modmon, it's globally similar.

See below for a sample with this script and a modem from VOO. Notice how, at least in my street, the modem uses 16 channels, ranging from 1 to 22 (typically 1-16; or another blend with 19-22, and without 5-8). Look at the "Frequency" chart, approx. Chart Nr 4.
![](/documentation/Technicolor_CGA4233_VOO/Screenshot%202022-03-21%20at%2021-53-20%20modmon.png)

## Help
You can post about any issues and problems here: [Asuswrt-Merlin AddOns on SNBForums](https://www.snbforums.com/forums/asuswrt-merlin-addons.60/?prefix_id=21)
but I don't get there often, and I probably won't be available to help.

I guess you already understood, this is not a well-rounded well-tested solution for a large audience. This is proof that it could work for me; and if your setup is similar; and you have a similar skillset, you will probably be able to get there with less effort than I did originally. Use it if you like, if you are interested in experimenting, not if you need a reliable solution.

Known issues:
The choice of timeslice (daily, weekly, monthly) should apply to all graphs. Because it does not, RxPwr_daily might have to display 16 lines/channels while RxCorrected_weekly would have to display 20 lines/channels. This makes the filtering from the global Rx channels selection a bit un-intuitive.
Legend is so dynamic that channel 22 in chart A may have a different colour than 22 in chart B, and different between 
chart produced today, or tomorrow (because Channel 22 has suddenly appeared overnight).
