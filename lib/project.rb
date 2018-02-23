class Project
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.title().==(another_list.title())
  end

  def self.all
    returned_lists = DB.exec("SELECT * FROM projects;")
    lists = []
    returned_lists.each() do |list|
      title = list.fetch("title")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end
#

#
#
#   def self.find(id)
#       found_list = nil
#       List.all().each() do |list|
#         if list.id().==(id)
#           found_list = list
#         end
#       end
#       found_list
#     end
#
#   def tasks
#     list_tasks = []
#     tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id()};")
#     tasks.each() do |task|
#       description = task.fetch("description")
#       list_id = task.fetch("list_id").to_i()
#       list_tasks.push(Task.new({:description => description, :list_id => list_id}))
#     end
#     list_tasks
#   end
#
#   def update(attributes)
#      @name = attributes.fetch(:name)
#      @id = self.id()
#      DB.exec("UPDATE lists SET name = '#{@name}' WHERE id = #{@id};")
#    end
#
end
