########################################################################################################################
#!!
#! @description: For valid response try integer IDs with positive integer value. Negative or non-integer values will generate API errors
#!
#! @input authentication_auth_type: Authentication type (Anonymous/Basic/Digest/Bearer)
#! @input order_id: ID of the order that needs to be deleted
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
namespace: swagger_petstore.store.order
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
        - method: DELETE
        - url: ${url}
        - auth_type: ${authentication_auth_type}
        - headers: ${''}
  inputs:
  - order_id
  - url: ${get_sp('swagger_petstore_base_url')+'/store/order/'+order_id+''}
  - authentication_auth_type: ${get_sp('swagger_petstore_auth_type')}
  name: delete_order
  results:
  - SUCCESS
  - FAILURE
