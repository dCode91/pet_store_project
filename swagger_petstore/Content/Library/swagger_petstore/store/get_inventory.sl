########################################################################################################################
#!!
#! @description: Returns a map of status codes to quantities
#!
#! @input url: The URL for the HTTP call
#! @input authentication_auth_type: Authentication type (Anonymous/Basic/Digest/Bearer)
#!
#! @output return_result: Response of the operation.
#! @output error_message: Return_result when the return_code is non-zero (e.g. network or other failure).
#! @output status_code: Status code of the HTTP call.
#! @output return_code: '0' if success, '-1' otherwise.
#! @output response_headers: Response headers string from the HTTP Client REST call.
#!
#! @result SUCCESS: Operation succeeded (statusCode is contained in valid_http_status_codes list).
#! @result FAILURE: Operation failed (statusCode is not contained in valid_http_status_codes list).
#!!#
########################################################################################################################
namespace: swagger_petstore.store
flow:
  name: get_inventory
  inputs:
    - url: "${get_sp('swagger_petstore_base_url')+'/store/inventory'}"
    - authentication_auth_type: "${get_sp('swagger_petstore_auth_type')}"
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - method: GET
            - url: '${url}'
            - auth_type: '${authentication_auth_type}'
            - headers: "${''}"
        publish:
          - return_result: "${cs_json_query(return_result,'available')}"
          - error_message
          - status_code
          - return_code
          - response_headers
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result: '${return_result}'
    - error_message: '${error_message}'
    - status_code: '${status_code}'
    - return_code: '${return_code}'
    - response_headers: '${response_headers}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_action:
        x: 100
        'y': 150
        navigate:
          2033d03f-662a-a9fd-13c2-b3e58050d4bb:
            targetId: ca05eef6-7085-0ae7-d230-206e4d08e626
            port: SUCCESS
    results:
      SUCCESS:
        ca05eef6-7085-0ae7-d230-206e4d08e626:
          x: 486
          'y': 149
