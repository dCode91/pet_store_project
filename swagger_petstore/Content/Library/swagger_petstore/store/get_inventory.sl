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
          - return_result: "${cs_json_query(return_result,'available') + ' still available.'}"
          - error_message
          - status_code
          - return_code
          - response_headers
        navigate:
          - SUCCESS: send_mail
          - FAILURE: on_failure
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: localhost
            - port: '443'
            - from: daniel
            - to: you
            - subject: cc
            - body: this is a demo body
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
        x: 78
        'y': 141
      send_mail:
        x: 283
        'y': 137
        navigate:
          bdb4d603-d108-e69b-faff-b8a332e35151:
            targetId: fcbad59c-6b17-509f-0052-3dc392471f13
            port: SUCCESS
    results:
      SUCCESS:
        fcbad59c-6b17-509f-0052-3dc392471f13:
          x: 508
          'y': 125
