DECLARE @json NVARCHAR(MAX) = '{
  "CUSTOMERS": [
    {
      "CUSTOMER": {
        "custid": 1,
        "age": 25,
        "name": "John Smith",
        "demographics": {
          "hhi": ">500k",
          "education": "college"
        }
      }
    },
    {
      "CUSTOMER": {
        "custid": 2,
        "age": 43,
        "name": "Tom Brady",
        "demographics": {
          "hhi": ">500k",
          "education": "college"
        },
        "dob": "1997-08-03"
      }
    }
  ]
}';

SELECT JSON_QUERY(@json, '$.CUSTOMERS') AS Customers;
