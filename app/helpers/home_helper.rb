module HomeHelper
	def body_classes
    "#{controller.controller_name} #{controller.action_name}"
	end
end
