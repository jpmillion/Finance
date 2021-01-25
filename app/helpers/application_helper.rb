module ApplicationHelper
    def messages_for_errors(model)
        if model.errors.any?
            tag.div id: "error_explanation" do
                    model.errors.full_messages.each do |message|
                        tag.li message
                    end

            end
        end
    end
end
