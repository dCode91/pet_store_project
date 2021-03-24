########################################################################################################################
#!!
#! @description: Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
#!
#! @input tags: Tags to filter by
#! @input authentication_auth_type: Authentication type (Anonymous/Basic/Digest/Bearer)
#! @input url: The URL for the HTTP call
#!
#! @output return_code: '0' if success, '-1' otherwise.
#! @output return_result: Response of the operation.
#! @output error_message: Return_result when the return_code is non-zero (e.g. network or other failure).
#! @output response_headers: Response headers string from the HTTP Client REST call.
#! @output status_code: Status code of the HTTP call.
#!
#! @result FAILURE: Operation failed (statusCode is not contained in valid_http_status_codes list).
#! @result SUCCESS: Operation succeeded (statusCode is contained in valid_http_status_codes list).
#!!#
########################################################################################################################
namespace: swagger_petstore.pet
flow:
  outputs:
  - return_result: ${return_result}
  - error_message: ${error_message}
  - status_code: ${status_code}
  - return_code: ${return_code}
  - response_headers: ${response_headers}
  workflow:
  - http_client_action:
      navigate:
      - SUCCESS: SUCCESS
      - FAILURE: on_failure
      publish:
      - return_result
      - error_message
      - status_code
      - return_code
      - response_headers
      do:
        io.cloudslang.base.http.http_client_action:
        - method: GET
        - query_params: ${'tags='+tags}
        - url: ${url}
        - auth_type: ${authentication_auth_type}
        - headers: ${''}
  inputs:
  - tags
  - url: ${get_sp('swagger_petstore_base_url')+'/pet/findByTags'}
  - authentication_auth_type: ${get_sp('swagger_petstore_auth_type')}
  name: find_pets_by_tags
  results:
  - SUCCESS
  - FAILURE
