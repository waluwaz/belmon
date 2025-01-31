# belmon
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/91af8db9cd354643a8ef6a7117be90fb)](https://www.codacy.com/app/waluwaz/belmon?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=waluwaz/belmon&amp;utm_campaign=Badge_Grade)
![Shellcheck](https://github.com/waluwaz/belmon/actions/workflows/shellcheck.yml/badge.svg)

## v0.7.0-beta
### Updated on 2022-05-16
## About
belmon is a tool that tracks your cable modem's stats (such as signal power levels) for AsusWRT Merlin with charts for daily, weekly and monthly summaries. 
It is mostly identical to modmon created by JackYaz. However, belmon is customized for another modem, the Technicolor CGA4233 installed by VOO to its customers in Belgium. 

Compared to the version of Jack, it queries the modem every 15 minutes. Its installation is tedious, see below. If this is completely mysterious to you, this beta software might not be a satisfying experience for you.

belmon is free to use under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0) (GPL 3.0).

If you have yet another modem, you can also look at the branch https://github.com/waluwaz/belmon/tree/Example-of-minimum-changes-for-new-modem-support (or version 0.1 in master). It's an example of a simple dirty approach at supporting another modem, roguely sticking new metrics in the original 6 metrics of modmon.
Since version 0.2, this is customized to use its own set of 7 metrics, in line with what's available from the VOO modem.

### Supporting development
If you have good experience with the script, share the word at https://forum.adsl-bc.org/viewforum.php?f=58 or https://www.snbforums.com/forums/asuswrt-merlin-addons.60/ for instance.
Temporarily, you could also PM me.

## Recommended firmware versions
You must be running firmware Merlin 384.15/384.13_4 or Fork 43E5 (or later) [Asuswrt-Merlin](https://www.asuswrt-merlin.net/)

## Installation
WARNING: 
This addon doesn't have a community of testers. I don't have the skills of regular addon writers. Use at your own risk.
If you don't have a backup router, remember that you're risking the stability of a critical piece of your infrastructure, with mostly unsupported/untested software. (The fact that I apparently never "broke" my router doesn't guarantee yours will be safe. )
Moreover, information might be power, but the addon is unlikely to inform you of anything that you will have direct control on.
Indirectly, charts and figures might help you convincing your ISP to seriously adress issues though, if you do experience issues (e.g. excessive packet drops).

I have made an attempt to allow coexistence of modmon and belmon (even though there is probably no point to run both).
If you do have the original modmon, there is still a chance/risk that they will interfere with each other. 

So, if you still want to install...

Using your preferred SSH client/terminal, copy and paste the following command, then press Enter:

```sh
/usr/sbin/curl --retry 3 "https://raw.githubusercontent.com/waluwaz/belmon/master/belmon.sh" -o "/jffs/scripts/belmon" && chmod 0755 /jffs/scripts/belmon && /jffs/scripts/belmon install
```

WARNING: It will almost certainly not work, and not collect any stats at first. So, you will need to modify the belmon file in /jffs/scripts. You could use vi on the router. Alternatively, you could edit the file on your usual machine and FTP the file. If you use FTP, note that the file needs to have execute right. "chmod a+x /jffs/scripts/belmon"
The new content must have customized curl commands targetting your modem, for instance at 192.168.100.1, with the custom authentication information.
Those curl commands are currently located around line 798 and 1047 in the script (as of V0.5.1-beta).

You can find the target curl command with F12 (Developer tools)/Network/Reload/"Copy as curl" while accessing the VOO webui in a Browser. More specifically, if you access the page about DOCSIS signal, you can filter for JSON requests, or on the "USTbl" string. 
For belmon around line 798, you should preferably replace the 'curl' keyword in the command provided by the browser, with '/usr/sbin/curl -fs --retry 3 --connect-timeout 15'. You will also need to add at the end of the curl statement: ' > "$shstatsfile_curl"'. Look at the code, you'll get the idea. If you are somewhat versed in scripts, it is probably much easier than it seems. (NB: The curl statement in belmon has been somewhat minimized, removing some unnecessary parameters. It is probably optional. You can probably keep all parameters provided by the browser. )

For line 1047, use a similar curl, but make sure the part after "modem/" refers to 'LogTbl'. Make sure you respect the same start and ending for that line as what you will find in belmon (as of v0.5.1 roughly '/usr/sbin/curl -fs --retry 3 --connect-timeout 15 '     and   '| jq '.data.LogTbl' | sed 's/__id/A__id/' | sed 's/"//g' | sed 's/: /,,/'  > "$shstatsfile_logtbl"')

This modification might have to be renewed, e.g. if the modem reboots for instance (also possibly if you subsequently create a session in the webui in a browser). If it still doesn't work, you could check another add-on from JackYaz. There might be some prerequisites that I forgot to mention (e.g. about the USB stick, formatting etc).

## Usage
### WebUI
belmon can be configured via the WebUI, in the Addons section. I recommend you use USB and not JFFS, in those settings. See the statement from RMerlin at https://github.com/RMerl/asuswrt-merlin.ng/wiki/JFFS.

### Command Line
To launch the belmon menu after installation, use:
```sh
belmon
```

If this does not work, you will need to use the full path:
```sh
/jffs/scripts/belmon
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
