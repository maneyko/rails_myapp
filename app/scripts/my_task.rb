class MyTask
  attr_reader :a
  attr_accessor :a
  def initialize(a = 4)
    @a = a
  end

  def self.run
    Thread.new do
      script_runner = ScriptRunner.where(name: self.name.underscore).first
      script_runner.running!

      result = %x{ps aux --sort -rss | awk '{n+=$4}END{print n}' && sleep 15}.chomp
      script_runner.not_running!
      result
    end
  end
end
