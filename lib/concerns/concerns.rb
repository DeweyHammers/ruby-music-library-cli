module Concerns
    module Findable
        def find_by_name(name)
            match = nil
            self.all.collect {|find| find.name == name ? match = find : match = nil}
            match
        end

        def find_or_create_by_name(name)
            match = find_by_name(name)
            match == nil ? name = self.create(name) : match
        end
    end
end