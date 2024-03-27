# PowerSchool Plugin for Avela Enroll

[PowerSchool] Plugin for [Tulsa Public Schools]’ integration with [Avela Enroll].

- [Requirements](#requirements)
- [How to Use](#how-to-use)
  - [Generate Plugin Zip File](#generate-plugin-zip-file)
  - [Console](#console)
    - [API Client](#api-client)
    - [Plugin PowerQuery Resources](#plugin-powerquery-resources)

## Requirements

- Ruby 3
- Make

## How to Use

The [Makefile](Makefile) includes several helpful commands. Use `make help` for more information.

### Generate Plugin Zip File

```console
$ make release
bin/release
creating: /…/ps-avela-enrollment/dist/avela-enrollment-v0.7.1.zip
    adding: plugin.xml
    adding: queries_root/org.avela.named_queries.xml
```

### Console

An interactive console is available to experiment with the API and PowerQueries.

These environment variables are required. Use an `.env` file or any other typical environment setup.

- `POWERSCHOOL_BASE_URI`
  - production: https://powerschool.tulsaschools.org
  - test: https://pstest.tulsaschools.org
- `POWERSCHOOL_CLIENT_PLUGIN_NAMESPACE`
  - *org.tulsaschools.avela*
- `POWERSCHOOL_CLIENT_ID` … *Client ID* from the *Data Provider configuration* link found on the plugin page
- `POWERSCHOOL_CLIENT_SECRET` … *Client Secret* from the *Data Provider configuration* link found on the plugin page

#### API Client

```console
❯ make console
bin/console
[1] pry(main)> PowerSchool.client.run command: :get, api_path: '/ws/v1/district'
=> {"district"=>
  {"@expansions"=>
    "entry_codes, test_setup, exit_codes, districts_of_residence, federal_race_categories, district_race_codes, ethnicity_race_decline_to_specify, scheduling_reporting_ethnicities, fees_payment_methods",
   "uuid"=>"e4db124f-611b-3b3a-b253-9123e99bd418",
   "name"=>"Tulsa Public Schools",
   "district_number"=>"72I001",
   "addresses"=>{"physical"=>{"street"=>"3027 South New Haven Avenue", "city"=>"Tulsa", "state_province"=>"OK", "postal_code"=>74127}},
   "phones"=>{"main"=>{"number"=>"918-746-6800"}, "fax"=>{"number"=>"918-746-6130"}}}}
```

#### Plugin PowerQuery Resources

```console
$ make console
bin/console
[1] pry(main)> PowerSchool.powerquery path: 'schoolInfo', body: { school_number: 735 }
=> #<PowerSchool::PowerQuery::Response:0x0000000104444cb0
 @count=nil,
 @extensions="s_sch_crosslea_x,s_sch_ncea_x,schoolssuccessnetfields,c_school_registrar,schoolscorefields,s_sch_crdc_x,s_sch_x,s_ok_sch_x,integration_schools",
 @name="schools",
 @records=
  [{"schoolnumber"=>"735",
    "_name"=>"schools",
    "alternateschoolnumber"=>"0",
    "highgrade"=>"12",
    "lowgrade"=>"9",
    "_id"=>109,
    "schoolsdcid"=>"109",
    "abbreviation"=>"BTW",
    "schoolname"=>"WASHINGTON HIGH SCHOOL"}],
 @response=
  {"name"=>"schools",
   "record"=>
    [{"schoolnumber"=>"735",
      "_name"=>"schools",
      "alternateschoolnumber"=>"0",
      "highgrade"=>"12",
      "lowgrade"=>"9",
      "_id"=>109,
      "schoolsdcid"=>"109",
      "abbreviation"=>"BTW",
      "schoolname"=>"WASHINGTON HIGH SCHOOL"}],
   "@extensions"=>"s_sch_crosslea_x,s_sch_ncea_x,schoolssuccessnetfields,c_school_registrar,schoolscorefields,s_sch_crdc_x,s_sch_x,s_ok_sch_x,integration_schools"}>
```

[PowerSchool]: https://www.powerschool.com/
[Tulsa Public Schools]: https://www.tulsaschools.org/
[Avela Enroll]: https://avela.org/enroll
