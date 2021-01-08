local wsl_guid = '{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}';
local scheme(var) = 'Selenized ' + var;

function(WSL_DISTRO_NAME,
         s_variant,
         s_bg_0,
         s_bg_1,
         s_bg_2,
         s_dim_0,
         s_fg_0,
         s_fg_1,
         s_red,
         s_green,
         s_yellow,
         s_blue,
         s_magenta,
         s_cyan,
         s_orange,
         s_violet,
         s_br_red,
         s_br_green,
         s_br_yellow,
         s_br_blue,
         s_br_magenta,
         s_br_cyan,
         s_br_orange,
         s_br_violet)
  {
    defaultProfile: wsl_guid,
    schemes: [{
      name: scheme(s_variant),
      background: s_bg_0,
      foreground: s_fg_0,
      selectionBackground: s_fg_0,
      cursorColor: s_fg_0,
      black: s_bg_1,
      red: s_red,
      green: s_green,
      yellow: s_yellow,
      blue: s_blue,
      purple: s_magenta,
      cyan: s_cyan,
      white: s_dim_0,
      brightBlack: s_bg_2,
      brightRed: s_br_red,
      brightGreen: s_br_green,
      brightYellow: s_br_yellow,
      brightBlue: s_br_blue,
      brightPurple: s_br_magenta,
      brightCyan: s_br_cyan,
      brightWhite: s_fg_1,
    }],
    profiles: {
      defaults: {
        antialiasingMode: 'cleartype',
        cursorShape: 'filledBox',
        fontFace: 'Source Code Pro for Powerline',
        fontSize: 12,
        fontWeight: 'medium',
      },
      list: [
        {
          guid: '{61c54bbd-c2c6-5271-96e7-009a87ff44bf}',
          name: 'Windows PowerShell',
          commandline: 'powershell.exe',
          hidden: false,
          colorScheme: scheme(s_variant),
        },
        {
          guid: '{0caa0dad-35be-5f56-a8ff-afceeeaa6101}',
          name: 'Command Prompt',
          commandline: 'cmd.exe',
          hidden: false,
          colorScheme: scheme(s_variant),
        },
        {
          guid: '{b453ae62-4e3d-5e58-b989-0a998ec441b8}',
          hidden: false,
          name: 'Azure Cloud Shell',
          source: 'Windows.Terminal.Azure',
          colorScheme: scheme(s_variant),
        },
        {
          guid: wsl_guid,
          hidden: false,
          name: WSL_DISTRO_NAME,
          source: 'Windows.Terminal.Wsl',
          colorScheme: scheme(s_variant),
          startingDirectory: '\\\\wsl$\\' + WSL_DISTRO_NAME + '\\home\\dylan',
        },
      ],
    },
    actions: [
      {
        command: {
          action: 'copy',
          singleLine: false,
        },
        keys: 'ctrl+shift+c',
      },
      {
        command: 'paste',
        keys: 'ctrl+shift+v',
      },
      {
        command: 'find',
        keys: 'ctrl+shift+f',
      },
      {
        command: { action: 'splitPane', split: 'auto', splitMode: 'duplicate' },
        keys: 'alt+shift+d',
      },
    ],
  }
