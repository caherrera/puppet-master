Puppet::Functions.create_function(:'master::mallocation') do
  dispatch :up do
    param 'Integer', :total
    return_type 'String'

  end

  def up(total)
    case total
    when 0..1050904576
      return '512m'
    else
      return ((total - 525452288).to_i).to_s
    end
  end
end