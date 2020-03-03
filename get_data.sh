(
  mkdir data
  cd data || exit
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2009-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2010-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2011-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2012-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-vendor_lookup-csv.csv
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-payment_lookup-csv.csv
)