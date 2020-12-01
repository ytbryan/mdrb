require 'json'

module MD

  #checking the syntax of the markdown
  # return true or false
  def self.check(path_to_syntax)

  end

  # MD.exist? is like File.exist?
  # May include better error next time
  def self.exist?(path) 
    return true if existence?(path)
    false
  end

  def self.create(path, content)
    touch(path)
    write(path, content)
  end

  def self.create_many(path_array, content_array)
    return MDError("Different in the length of arrays") if difference_in_length?(path_array, content_array)
    path_array.each {|each_path|
      touch(each_path)
    }

    content_array.each_with_index {|each_content, index|
      write(path_array[index], each_content)
    }
  end

  # This is read but return it 
  # as a json file
  def self.to_json(path)
    array = File.readlines(marked_down(path))
    answer = []
    array.each_with_index { |item, i|
      answer.push(i)
      answer.push(item)
    }
    return Hash[*answer].to_json
  end

  def self.to_json_many(path_array)
    answer = []
    path_array.each {|path|
      answer.push(to_json(path))
    }
    answer
  end

  # read the file
  def self.read(path)
    File.read(marked_down(path))
  end

  #read many markdown
  def self.read_many(path_array)
    answer = []
    path_array.each {|path|
      answer.push(File.readlines(marked_down(path)))
    }
    answer
  end

  # move the file
  def self.move(path, newpath)
    FileUtils.mv(marked_down(path), marked_down(newpath))
  end

  #move many of the file
  def self.move_many(path_array, new_path_array)
    return MDError("Different in size") if path_array.length != new_path_array.length
    new_path_array.each_with_index { |each_new_p, i|
      move(path_array[i], each_new_p)
    }
  end

  # remove the file
  def self.delete(path)
    File.delete(marked_down(path))
  end
  
  # delete many markdown
  def self.delete_many(path_array)
    path_array.each {|path|
      File.delete(marked_down(path))
    }
  end

  # update the markdown
  def self.update(path, content)
    return MDError("File too big") if file_too_big?(path) == true    
    move(path, path+".draft")
    create(path, content) #create 
    delete(path+".draft") #delete
  end

  # update many markdown
  def self.update_many(path_array, content_array)
    return MDError("Different in the length of arrays") if difference_in_length?(path_array, content_array)
    content_array.each_with_index { |each_content, i|
      update(path_array[i], each_content)
    }
  end

  # append to the markdown file
  def self.append(path, content)
    add(path, content)
  end

  # append many markdown
  def self.append_many(path_array, content_array)
    content_array.each_with_index {|each_content, i|
      add(path_array[i], each_content)
    }
  end

  # update on the single line
  def self.update_on(which_line, path, content)
    return MDError("File too big") if file_too_big?(path)
    array = File.readlines(path)
  end
  
  # read the line of markdown
  def self.read_line(which_line, path_to_file)
    return MDError("File too big") if file_too_big?(path)
    array = File.readlines(path)
    array[which_line] if array != nil && array.length >= which_line
  end

  # list all the markdown files in the 
  # directory
  def self.list(path)
    tasks_array = Dir.entries(path).sort_by { |x| File.birthtime(path + x) }
    
    return tasks_array.reject {|f|
      f[0].include?('.') || is_md_extension? == true
    }.collect {|x| (path + x)}
  end

  private #=================================================

  def self.existence?(path)
    File.exist?(marked_down(path)) == true
  end

  # TODO check if the file is too big\
  def self.file_too_big?(path)
    false
  end

  # Bryan, you can do better with the naming of marked_down
  # always produce a path that has .md 
  def self.marked_down(path)
    if is_md_extension?(path.dash)
      path
    else 
      path + ".md"
    end
  end
  
  def self.difference_in_length?(path_array, content_array)
    path_array.length != content_array.length
  end

  def self.add(path,content)
    File.write(marked_down(path.dash), content, mode: "a")
  end

  def self.write(path, content)
    File.write(marked_down(path.dash), content, mode: "w")
  end

  def self.touch(path)
    FileUtils.touch(marked_down(path.dash))
  end

  def self.is_md_extension?(path)
    path[path.length-3..path.length] == ".md"
  end
end

module MDError
  def initialize(str)
    puts str
  end
end

class String
  def dash
    self.gsub(" ", "-").strip
  end
end
