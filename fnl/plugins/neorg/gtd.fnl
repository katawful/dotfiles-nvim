(module plugins.neorg.gtd
        {require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;;; Handles switching GTD workspaces until it is fixed

(local dirman (require :neorg.modules.core.norg.dirman.module))
(local gtd (require :neorg.modules.core.gtd.base.module))

(defn physical-workspace [] "Get the current physical Neorg workspace"
      (. (dirman.public.get_current_workspace) 1))

(defn change-gtd-workspace [] "Changes the gtd workspace"
      (tset gtd.config.public :workspace (physical-workspace)))

(defn reload-gtd [] "Reloads GTD" (neorg.modules.load_module :core.gtd.base))
