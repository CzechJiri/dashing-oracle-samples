require 'oci8'
 
SCHEDULER.every '10s', :first_in => 0 do |job|
  begin
  conn =  OCI8.new(ENV['ORACLE_USER'], ENV['ORACLE_PASSWORD'], ENV['ORACLE_TNS'])
 
  mylist = Hash.new 
  conn.exec("
              select field1, count(*) from mytable group by field1
            ") do |r|    
             
    mylist[r[0]] = { label: r[0], value: r[1].to_i.to_s }
  end
  send_event('oracle-list', { items: mylist.values })
   
  conn.logoff  
 
  rescue Exception => e
    puts e.message
  end
   
end
