User = Struct.new(:developer_key, :client_key, :account, :authorization) do
  def auth_header
    "#{developer_key}:#{client_key}"
  end
end
