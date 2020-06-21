class CreateContacts < ActiveRecord::Migration[6.0]
  def change
  	create_table :contacts do |t|
	t.text :clientemail
	t.text :clientmessage
	

	t.timestamps
	
	end
  end
end
