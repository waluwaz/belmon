# modmon
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/91af8db9cd354643a8ef6a7117be90fb)](https://www.codacy.com/app/jackyaz/modmon?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jackyaz/modmon&amp;utm_campaign=Badge_Grade)
![Shellcheck](https://github.com/jackyaz/modmon/actions/workflows/shellcheck.yml/badge.svg)

## v0.2.0-alpha
### Updated on 2022-03-16
## About
modmon is a tool that tracks your cable modem's stats (such as signal power levels) for AsusWRT Merlin with charts for daily, weekly and monthly summaries. It was created by JackYaz. This repository has a derivative work based on modmon and customized to work with another modem, the Technicolor CGA4233 from VOO in Belgium. It doesn't have a specific name, because I'm not sure how to change the name without breaking it   ;-)  ; also because it probably couldn't coexist with the original modmon, and finally because I can't imagine a scenario where someone would concurrently need the original modmon and my hack.

So, my work tries to support the Technicolor CGA4233 from VOO in Belgium. Compared to the version of Jack, it hammers the modem every 15 minutes. It probably needs you to update the curl command around line 815 of modmon.sh, and paste the tokens for PHP session and authentication (also in CSRF). I got them with F12 (Developer tools)/Network/Reload/Copy as curl. 

modmon voo is free to use under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0) (GPL 3.0).

### Supporting development
Love the script ? Any and all donations gratefully sent to JackYaz who did 100% of the work for the original modmon, which means 99% of the work for this. For more reliability, please navigate to Jack's repo and click Paypal from his repo.

## Recommended firmware versions
You must be running firmware Merlin 384.15/384.13_4 or Fork 43E5 (or later) [Asuswrt-Merlin](https://www.asuswrt-merlin.net/)

## Installation
Install the original modmon from JackYaz in version 1.1.8. See his instructions.
Replace the modmon file in /jffs/scripts with the modmon.sh from my repo. ! The name in the router must be modmon, not modmon.sh.
(NB: In the future, I might customize other files which would also need to be copied to the router. The commit dates might give you a clue.) Also update the .asp file at /jffs/addons/modmon.d
The modmon file on the router must be executable (chmod a+x).
I guess my Master branch is your best bet.

Alternatively, if you are feeling lucky, you could try the following, untested approach to install:

Using your preferred SSH client/terminal, copy and paste the following command, then press Enter:

```sh
/usr/sbin/curl --retry 3 "https://raw.githubusercontent.com/waluwaz/modmon/master/modmon.sh" -o "/jffs/scripts/modmon" && chmod 0755 /jffs/scripts/modmon && /jffs/scripts/modmon install
```

And anyway, don't forget the special dance to adapt the script to an active session. See above. This modification might have to be renewed, e.g. if the modem reboots for instance.

## Usage
### WebUI
modmon can be configured via the WebUI, in the Addons section.

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
See Jack's repo for the flavour of the UI.
![](/documentation/Technicolor_CGA4233_VOO/Screenshot%202022-03-21%20at%2021-53-20%20modmon.png)

## Help
You can post about any issues and problems here: [Asuswrt-Merlin AddOns on SNBForums](https://www.snbforums.com/forums/asuswrt-merlin-addons.60/?prefix_id=21)
but I don't get there often, and I probably won't be available to help.

I guess you already understood, this is not a well-rounded solution for a large audience. This is proof that it could work for me; and if your setup is similar; and you have a similar skillset, you will probably be able to get there with less effort than I did originally. Use it if you like, if you are interested in experimenting, not if you need a reliable solution.

Known issues:
The timestamps in the log table are wrong. The order is probably wrong too.
Legend is so dynamic that channel 22 in chart A may have a different colour than 22 in chart B.
Count of "graphic lines" in charts is somewhat buggy. The filtering is usually not display, even though it shoud be displayed.
!! Filtering not working on Uncorrectable, that has only 16 channels, instead of 20.
The choice of timeslice (daily, weekly, monthly) should apply to all graphs.
The choice of timeslice in zoom (e.g. from 19:00 'til 22:00) should apply to all graphs.

?? debug draw_chart
