
---
### [choco://insomnia-dotnet](choco://insomnia-dotnet)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://community.chocolatey.org/packages/choco-protocol-support)

---

---

### Looking for the native version? Check out the [insomnia](https://community.chocolatey.org/packages/insomnia) package!

---

# Insomnia

The default power settings for Windows are configured so a computer will go to sleep after 15-30 minutes of inactivity (e.g., no mouse or keyboard input). This is great because a computer that's not being used doesn't need to be running at full power. By letting an idle machine enter sleep mode, the user benefits from a significant reduction in electricity use, heat generation, component wear, etc.. And because sleep preserves the state of everything in memory, it's quick to enter, quick to exit, and doesn't affect your workflow. All the same applications continue running, windows stay open and where they were, and so on. Sleep mode is a *Good Thing*.

But sometimes a computer is busy even though you aren't using the mouse and keyboard; common examples include playing a movie, burning a DVD, streaming music, etc.. In these cases, you do **not** want the machine to go to sleep because you're using it - even though you're not *actually* using it! So most media players and disc burners tell Windows not to go to sleep while they're running. In fact, there's a dedicated API for exactly this purpose: the [SetThreadExecutionState Win32 Function](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate).

But what about those times when the computer is doing something useful and the relevant program does not suppress the default sleep behavior? It might be downloading a large file, re-encoding a music collection, or backing up the hard drive, for example. In times like this, you don't want the machine to go to sleep **right now**, but are otherwise happy with the default sleep behavior. Unfortunately, the easiest way to temporarily suppress sleeping is to go to Control Panel, open the Power Options page, change the power plan settings, commit them - and then remember to undo everything when you're done. It's not hard; but it's kind of annoying...

![Insomnia Screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-insomnia-dotnet@b0f425b1edec3fe1ef231bc6570a23adc7ec5405/Screenshot.png)

**Insomnia makes it better!** Insomnia is a simple program that calls the `SetThreadExecutionState` API to disable sleep mode for as long as it's running. Closing the Insomnia window immediately returns to whatever sleep mode was in effect before it was run. Yes, it's that simple!

**Aside:** To be clear, the *display* can still go to sleep and power off - it's just sleep for the *computer* that is blocked. Similarly, if you *tell* the machine to go to sleep by hitting the power button, it will still do so.

## Package Parameters
* `/NoShim` - Opt out of creating a GUI shim.
* `/NoDesktopShortcut` - Opt out of creating a Desktop shortcut.
* `/NoProgramsShortcut` - Opt out of creating a Programs shortcut in your Start Menu.
* `/Start` - Automatically start Insomnia after installation completes.

## Package Notes
This package is primarily intended to accommodate users who require or prefer use of the .NET binary specifically. Although versioning info and runtime requirements vary between the .NET and native binaries, both binary types should be functionally identical.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:
```
choco feature enable --name=useRememberedArgumentsForUpgrades
```
