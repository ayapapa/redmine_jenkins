require_dependency 'projects_helper'

module RedmineJenkinsProjectsHelperPatch
  #module Patches
    #module ProjectsHelperPatch

      #def self.included(base)
      #  base.send(:include, InstanceMethods)
      #  base.class_eval do
      #    unloadable

      #    #alias_method_chain :project_settings_tabs, :redmine_jenkins
      #    alias_method :project_settings_tabs_without_redmine_jenkins, :project_settings_tabs
      #    alias_method :project_settings_tabs, :project_settings_tabs_with_redmine_jenkins
      #  end
      #end


      #module InstanceMethods

        #def project_settings_tabs_with_redmine_jenkins(&block)
        def project_settings_tabs
          #tabs = project_settings_tabs_without_redmine_jenkins(&block)
          tabs = super
          if @project.module_enabled?('jenkins')
	        tabs.push({
	          :name    => 'jenkins',
	          :action  => :edit_jenkins_settings,
	          :partial => 'projects/settings/redmine_jenkins',
	          :label   => :label_jenkins
	        })
	        tabs.select {|tab| User.current.allowed_to?(tab[:action], @project)}
	      end
          tabs
        end

      #end

    #end
  #end
end

#unless ProjectsHelper.included_modules.include?(RedmineJenkins::Patches::ProjectsHelperPatch:InstanceMethods)
#  ProjectsHelper.send(:include, RedmineJenkins::Patches::ProjectsHelperPatch:InstanceMethods)
#end
ProjectsHelper.prepend(RedmineJenkinsProjectsHelperPatch)
