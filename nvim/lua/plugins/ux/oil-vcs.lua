return {
  "SirZenith/oil-vcs-status",
  config = function()
    local status_const = require "oil-vcs-status.constant.status"

    local StatusType = status_const.StatusType

    require("oil-vcs-status").setup {
      -- Executable path of each version control system.
      vcs_executable = {
        git = "git",
        svn = "svn",
      },

      ---@type integer
      fs_event_debounce = 500,

      ---@type table<oil-vcs-status.StatusType, string>
      status_symbol = {
        [StatusType.Added] = "",
        [StatusType.Copied] = "󰆏",
        [StatusType.Deleted] = "",
        [StatusType.Ignored] = "",
        [StatusType.Modified] = "",
        [StatusType.Renamed] = "",
        [StatusType.TypeChanged] = "󰉺",
        [StatusType.Unmodified] = " ",
        [StatusType.Unmerged] = "",
        [StatusType.Untracked] = "",
        [StatusType.External] = "",

        [StatusType.UpstreamAdded] = "󰈞",
        [StatusType.UpstreamCopied] = "󰈢",
        [StatusType.UpstreamDeleted] = "",
        [StatusType.UpstreamIgnored] = " ",
        [StatusType.UpstreamModified] = "󰏫",
        [StatusType.UpstreamRenamed] = "",
        [StatusType.UpstreamTypeChanged] = "󱧶",
        [StatusType.UpstreamUnmodified] = " ",
        [StatusType.UpstreamUnmerged] = "",
        [StatusType.UpstreamUntracked] = " ",
        [StatusType.UpstreamExternal] = "",
      },

      ---@type table<oil-vcs-status.StatusType, string | false>
      status_hl_group = {
        [StatusType.Added] = "OilVcsStatusAdded",
        [StatusType.Copied] = "OilVcsStatusCopied",
        [StatusType.Deleted] = "OilVcsStatusDeleted",
        [StatusType.Ignored] = "OilVcsStatusIgnored",
        [StatusType.Modified] = "OilVcsStatusModified",
        [StatusType.Renamed] = "OilVcsStatusRenamed",
        [StatusType.TypeChanged] = "OilVcsStatusTypeChanged",
        [StatusType.Unmodified] = "OilVcsStatusUnmodified",
        [StatusType.Unmerged] = "OilVcsStatusUnmerged",
        [StatusType.Untracked] = "OilVcsStatusUntracked",
        [StatusType.External] = "OilVcsStatusExternal",

        [StatusType.UpstreamAdded] = "OilVcsStatusUpstreamAdded",
        [StatusType.UpstreamCopied] = "OilVcsStatusUpstreamCopied",
        [StatusType.UpstreamDeleted] = "OilVcsStatusUpstreamDeleted",
        [StatusType.UpstreamIgnored] = "OilVcsStatusUpstreamIgnored",
        [StatusType.UpstreamModified] = "OilVcsStatusUpstreamModified",
        [StatusType.UpstreamRenamed] = "OilVcsStatusUpstreamRenamed",
        [StatusType.UpstreamTypeChanged] = "OilVcsStatusUpstreamTypeChanged",
        [StatusType.UpstreamUnmodified] = "OilVcsStatusUpstreamUnmodified",
        [StatusType.UpstreamUnmerged] = "OilVcsStatusUpstreamUnmerged",
        [StatusType.UpstreamUntracked] = "OilVcsStatusUpstreamUntracked",
        [StatusType.UpstreamExternal] = "OilVcsStatusUpstreamExternal",
      },

      ---@type table<oil-vcs-status.StatusType, number>
      status_priority = {
        [StatusType.UpstreamIgnored] = 0,
        [StatusType.Ignored] = 0,

        [StatusType.UpstreamUntracked] = 1,
        [StatusType.Untracked] = 1,

        [StatusType.UpstreamUnmodified] = 2,
        [StatusType.Unmodified] = 2,
        [StatusType.UpstreamExternal] = 2,
        [StatusType.External] = 2,

        [StatusType.UpstreamCopied] = 3,
        [StatusType.UpstreamRenamed] = 3,
        [StatusType.UpstreamTypeChanged] = 3,

        [StatusType.UpstreamDeleted] = 4,
        [StatusType.UpstreamModified] = 4,
        [StatusType.UpstreamAdded] = 4,

        [StatusType.UpstreamUnmerged] = 5,

        [StatusType.Copied] = 13,
        [StatusType.Renamed] = 13,
        [StatusType.TypeChanged] = 13,

        [StatusType.Deleted] = 14,
        [StatusType.Modified] = 14,
        [StatusType.Added] = 14,

        [StatusType.Unmerged] = 15,
      },
      vcs_specific = {
        git = {
          ---@type integer
          status_update_debounce = 200,
        },
      },
    }
  end,
}
