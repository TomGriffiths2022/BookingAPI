Before('@wip or @manual') do |_scenario|
  skip_this_scenario
end

Before do |scenario|
  LOG.new_scenario(scenario.id)
  LOG.info { "Running Scenario: #{scenario.name}" }
end

After do |scenario|
  LOG.info { "Finished running: '#{scenario.name}' from '#{scenario.location.file}'" }
end
