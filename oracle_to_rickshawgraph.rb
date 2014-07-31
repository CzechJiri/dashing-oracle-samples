require 'oci8'
 
points_field1 = []
points_field2 = []
last_x = 1
elements_total = 100
 
SCHEDULER.every '10s', :first_in => 0 do |job|
  begin
  conn =  OCI8.new(ENV['ORACLE_USER'], ENV['ORACLE_PASSWORD'], ENV['ORACLE_TNS'])
   
  conn.exec("
          select sum(field1)  field1,
                 sum(field2)  field2,
                 count(*)
            from mytable      
          ") do |r|
    last_x += 1
 
     
    points_field1  << { x: last_x, y: r[0].to_i }
    points_field2 << { x: last_x, y: r[1].to_i }
     
    series = [
              { name: "FIELD1",  data: points_field1.last(elements_total)  },
              { name: "FIELD2",  data: points_field2.last(elements_total)  }              
             ]
              
    send_event('oracle-graph', series: series )
  end
  conn.logoff  
   
  rescue Exception => e
    puts e.message
  end
   
end
