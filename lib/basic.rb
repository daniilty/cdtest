module Basic

  def Basic.cd_into(dir="")
    status = system("cd", dir)
    if status
      puts "all fine"
    else
      Basic.make_dir_and_cd(dir)
    end
  end

  def Basic.make_dir_and_cd(dir)
      status = system("mkdir", dir)
      if status
        system("cd", dir)
        puts "everything is still fine"
        system("rmdir", dir)
      end
  end
end
