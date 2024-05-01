using CEnum

"""
Empty struct that is passed when on\\_connection\\_closed is called. Currently holds nothing but will allow expanding in the future should it be needed.
"""
mutable struct on_connection_closed_data end

"""
    aws_mqtt_client

Documentation not found.
"""
struct aws_mqtt_client
    allocator::Ptr{aws_allocator}
    bootstrap::Ptr{aws_client_bootstrap}
    ref_count::aws_ref_count
end

"""
Documentation not found.
"""
mutable struct aws_mqtt_client_connection end

# typedef void ( aws_mqtt_op_complete_fn ) ( struct aws_mqtt_client_connection * connection , uint16_t packet_id , int error_code , void * userdata )
"""
Callback called when a request roundtrip is complete (QoS0 immediately, QoS1 on PUBACK, QoS2 on PUBCOMP). Either succeed or not
"""
const aws_mqtt_op_complete_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_complete_fn ) ( struct aws_mqtt_client_connection * connection , int error_code , enum aws_mqtt_connect_return_code return_code , bool session_present , void * userdata )
"""
Called when a connection attempt is completed, either in success or error.

If error code is AWS\\_ERROR\\_SUCCESS, then a CONNACK has been received from the server and return\\_code and session\\_present contain the values received. If error\\_code is not AWS\\_ERROR\\_SUCCESS, it refers to the internal error that occurred during connection, and return\\_code and session\\_present are invalid.
"""
const aws_mqtt_client_on_connection_complete_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_success_fn ) ( struct aws_mqtt_client_connection * connection , enum aws_mqtt_connect_return_code return_code , bool session_present , void * userdata )
"""
Documentation not found.
"""
const aws_mqtt_client_on_connection_success_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_failure_fn ) ( struct aws_mqtt_client_connection * connection , int error_code , void * userdata )
"""
Documentation not found.
"""
const aws_mqtt_client_on_connection_failure_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_interrupted_fn ) ( struct aws_mqtt_client_connection * connection , int error_code , void * userdata )
"""
Documentation not found.
"""
const aws_mqtt_client_on_connection_interrupted_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_closed_fn ) ( struct aws_mqtt_client_connection * connection , struct on_connection_closed_data * data , void * userdata )
"""
Called if the connection to the server is closed by user request Note: Currently the "data" argument is always NULL, but this may change in the future if additional data is needed to be sent.
"""
const aws_mqtt_client_on_connection_closed_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_resumed_fn ) ( struct aws_mqtt_client_connection * connection , enum aws_mqtt_connect_return_code return_code , bool session_present , void * userdata )
"""
Called when a connection to the server is resumed (if clean\\_session is true, calling [`aws_mqtt_resubscribe_existing_topics`](@ref) is suggested)
"""
const aws_mqtt_client_on_connection_resumed_fn = Cvoid

# typedef void ( aws_mqtt_suback_multi_fn ) ( struct aws_mqtt_client_connection * connection , uint16_t packet_id , const struct aws_array_list * topic_subacks , /* contains aws_mqtt_topic_subscription pointers */ int error_code , void * userdata )
"""
Called when a multi-topic subscription request is complete. Note: If any topic\\_suback's qos value is AWS\\_MQTT\\_QOS\\_FAILURE, then that topic subscription was rejected by the broker.
"""
const aws_mqtt_suback_multi_fn = Cvoid

# typedef void ( aws_mqtt_suback_fn ) ( struct aws_mqtt_client_connection * connection , uint16_t packet_id , const struct aws_byte_cursor * topic , enum aws_mqtt_qos qos , int error_code , void * userdata )
"""
Called when a single-topic subscription request is complete. Note: If the qos value is AWS\\_MQTT\\_QOS\\_FAILURE, then the subscription was rejected by the broker.
"""
const aws_mqtt_suback_fn = Cvoid

# typedef void ( aws_mqtt_client_publish_received_fn ) ( struct aws_mqtt_client_connection * connection , const struct aws_byte_cursor * topic , const struct aws_byte_cursor * payload , bool dup , enum aws_mqtt_qos qos , bool retain , void * userdata )
"""
Called when a publish message is received.

# Arguments
* `connection`:\\[in\\] The connection object
* `topic`:\\[in\\] The information channel to which the payload data was published.
* `payload`:\\[in\\] The payload data.
* `dup`:\\[in\\] DUP flag. If true, this might be re-delivery of an earlier attempt to send the message.
* `qos`:\\[in\\] Quality of Service used to deliver the message.
* `retain`:\\[in\\] Retain flag. If true, the message was sent as a result of a new subscription being made by the client.
"""
const aws_mqtt_client_publish_received_fn = Cvoid

# typedef void ( aws_mqtt_client_on_disconnect_fn ) ( struct aws_mqtt_client_connection * connection , void * userdata )
"""
Called when a connection is closed, right before any resources are deleted
"""
const aws_mqtt_client_on_disconnect_fn = Cvoid

# typedef void ( aws_mqtt_client_on_connection_termination_fn ) ( void * userdata )
"""
Signature of callback invoked on a connection destruction.
"""
const aws_mqtt_client_on_connection_termination_fn = Cvoid

# typedef void ( aws_mqtt_transform_websocket_handshake_complete_fn ) ( struct aws_http_message * request , int error_code , void * complete_ctx )
"""
Function to invoke when the websocket handshake request transformation completes. This function MUST be invoked or the application will soft-lock.

`request` and `complete_ctx` must be the same pointers provided to the [`aws_mqtt_transform_websocket_handshake_fn`](@ref). `error_code` should should be AWS\\_ERROR\\_SUCCESS if transformation was successful, otherwise pass a different AWS\\_ERROR\\_X value.
"""
const aws_mqtt_transform_websocket_handshake_complete_fn = Cvoid

# typedef void ( aws_mqtt_transform_websocket_handshake_fn ) ( struct aws_http_message * request , void * user_data , aws_mqtt_transform_websocket_handshake_complete_fn * complete_fn , void * complete_ctx )
"""
Function that may transform the websocket handshake request. Called each time a websocket connection is attempted.

The default request uses path "/mqtt". All required headers are present, plus the optional header "Sec-WebSocket-Protocol: mqtt".

The user MUST invoke the `complete_fn` when transformation is complete or the application will soft-lock. When invoking the `complete_fn`, pass along the `request` and `complete_ctx` provided here and an error code. The error code should be AWS\\_ERROR\\_SUCCESS if transformation was successful, otherwise pass a different AWS\\_ERROR\\_X value.
"""
const aws_mqtt_transform_websocket_handshake_fn = Cvoid

# typedef int aws_mqtt_validate_websocket_handshake_fn ( struct aws_mqtt_client_connection * connection , const struct aws_http_header * header_array , size_t num_headers , void * userdata )
"""
Function that may accept or reject a websocket handshake response. Called each time a valid websocket connection is established.

All required headers have been checked already (ex: "Sec-Websocket-Accept"),

Return AWS\\_OP\\_SUCCESS to accept the connection or AWS\\_OP\\_ERR to stop the connection attempt.
"""
const aws_mqtt_validate_websocket_handshake_fn = Cvoid

"""
    aws_mqtt_qos

Documentation not found.
"""
@cenum aws_mqtt_qos::UInt32 begin
    AWS_MQTT_QOS_AT_MOST_ONCE = 0
    AWS_MQTT_QOS_AT_LEAST_ONCE = 1
    AWS_MQTT_QOS_EXACTLY_ONCE = 2
    AWS_MQTT_QOS_FAILURE = 128
end

# typedef void ( aws_mqtt_userdata_cleanup_fn ) ( void * userdata )
"""
Function called on cleanup of a userdata.
"""
const aws_mqtt_userdata_cleanup_fn = Cvoid

"""
    aws_mqtt_topic_subscription

Passed to subscribe() and suback callbacks
"""
struct aws_mqtt_topic_subscription
    topic::aws_byte_cursor
    qos::aws_mqtt_qos
    on_publish::Ptr{aws_mqtt_client_publish_received_fn}
    on_cleanup::Ptr{aws_mqtt_userdata_cleanup_fn}
    on_publish_ud::Ptr{Cvoid}
end

"""
    aws_mqtt_connection_options

host\\_name The server name to connect to. This resource may be freed immediately on return. port The port on the server to connect to client\\_id The clientid to place in the CONNECT packet. socket\\_options The socket options to pass to the [`aws_client_bootstrap`](@ref) functions. This is copied into the connection tls\\_options TLS settings to use when opening a connection. This is copied into the connection Pass NULL to connect without TLS (NOT RECOMMENDED) clean\\_session True to discard all server session data and start fresh keep\\_alive\\_time\\_secs The keep alive value to place in the CONNECT PACKET, a PING will automatically be sent at this interval as well. If you specify 0, defaults will be used and a ping will be sent once per 20 minutes. This duration must be longer than ping\\_timeout\\_ms. ping\\_timeout\\_ms Network connection is re-established if a ping response is not received within this amount of time (milliseconds). If you specify 0, a default value of 3 seconds is used. Alternatively, tcp keep-alive may be away to accomplish this in a more efficient (low-power) scenario, but keep-alive options may not work the same way on every platform and OS version. This duration must be shorter than keep\\_alive\\_time\\_secs. protocol\\_operation\\_timeout\\_ms Timeout when waiting for the response to some operation requires response by protocol. Set to zero to disable timeout. Otherwise, the operation will fail with error AWS\\_ERROR\\_MQTT\\_TIMEOUT if no response is received within this amount of time after the packet is written to the socket. The timer is reset if the connection is interrupted. It applied to PUBLISH (QoS>0) and UNSUBSCRIBE now. Note: While the MQTT 3 specification states that a broker MUST respond, some brokers are known to ignore publish packets in exceptional circumstances (e.g. AWS IoT Core will not respond if the publish quota is exceeded). on\\_connection\\_complete The callback to fire when the connection attempt completes user\\_data Passed to the userdata param of on\\_connection\\_complete
"""
struct aws_mqtt_connection_options
    host_name::aws_byte_cursor
    port::UInt32
    socket_options::Ptr{aws_socket_options}
    tls_options::Ptr{aws_tls_connection_options}
    client_id::aws_byte_cursor
    keep_alive_time_secs::UInt16
    ping_timeout_ms::UInt32
    protocol_operation_timeout_ms::UInt32
    on_connection_complete::Ptr{aws_mqtt_client_on_connection_complete_fn}
    user_data::Ptr{Cvoid}
    clean_session::Bool
end

"""
    aws_mqtt_connection_operation_statistics

Contains some simple statistics about the current state of the connection's queue of operations
"""
struct aws_mqtt_connection_operation_statistics
    incomplete_operation_count::UInt64
    incomplete_operation_size::UInt64
    unacked_operation_count::UInt64
    unacked_operation_size::UInt64
end

"""
    aws_mqtt_client_new(allocator, bootstrap)

Creates an instance of [`aws_mqtt_client`](@ref).

# Arguments
* `allocator`:\\[in\\] The allocator the client will use for all future allocations
* `bootstrap`:\\[in\\] The client bootstrap to use to initiate new socket connections
# Returns
a new instance of an [`aws_mqtt_client`](@ref) if successful, NULL otherwise
### Prototype
```c
struct aws_mqtt_client *aws_mqtt_client_new(struct aws_allocator *allocator, struct aws_client_bootstrap *bootstrap);
```
"""
function aws_mqtt_client_new(allocator, bootstrap)
    ccall((:aws_mqtt_client_new, libaws_c_mqtt), Ptr{aws_mqtt_client}, (Ptr{aws_allocator}, Ptr{aws_client_bootstrap}), allocator, bootstrap)
end

"""
    aws_mqtt_client_acquire(client)

Increments the ref count to an mqtt client, allowing the caller to take a reference to it

# Arguments
* `client`:\\[in\\] The client to increment the ref count on
# Returns
the mqtt client
### Prototype
```c
struct aws_mqtt_client *aws_mqtt_client_acquire(struct aws_mqtt_client *client);
```
"""
function aws_mqtt_client_acquire(client)
    ccall((:aws_mqtt_client_acquire, libaws_c_mqtt), Ptr{aws_mqtt_client}, (Ptr{aws_mqtt_client},), client)
end

"""
    aws_mqtt_client_release(client)

Decrements the ref count on an mqtt client. If the ref count drops to zero, the client is cleaned up.

# Arguments
* `client`:\\[in\\] The client to release a ref count on
### Prototype
```c
void aws_mqtt_client_release(struct aws_mqtt_client *client);
```
"""
function aws_mqtt_client_release(client)
    ccall((:aws_mqtt_client_release, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt_client},), client)
end

"""
    aws_mqtt_client_connection_new(client)

Spawns a new connection object.

# Arguments
* `client`:\\[in\\] The client to spawn the connection from
# Returns
a new mqtt connection on success, NULL otherwise
### Prototype
```c
struct aws_mqtt_client_connection *aws_mqtt_client_connection_new(struct aws_mqtt_client *client);
```
"""
function aws_mqtt_client_connection_new(client)
    ccall((:aws_mqtt_client_connection_new, libaws_c_mqtt), Ptr{aws_mqtt_client_connection}, (Ptr{aws_mqtt_client},), client)
end

"""
Documentation not found.
"""
mutable struct aws_mqtt5_client end

"""
    aws_mqtt_client_connection_new_from_mqtt5_client(client)

Creates a new MQTT311 connection object that uses an MQTT5 client under the hood

# Arguments
* `client`:\\[in\\] The mqtt5 client to create the connection from
# Returns
a new mqtt (311) connection on success, NULL otherwise
### Prototype
```c
struct aws_mqtt_client_connection *aws_mqtt_client_connection_new_from_mqtt5_client(struct aws_mqtt5_client *client);
```
"""
function aws_mqtt_client_connection_new_from_mqtt5_client(client)
    ccall((:aws_mqtt_client_connection_new_from_mqtt5_client, libaws_c_mqtt), Ptr{aws_mqtt_client_connection}, (Ptr{aws_mqtt5_client},), client)
end

"""
    aws_mqtt_client_connection_acquire(connection)

Increments the ref count to an mqtt client connection, allowing the caller to take a reference to it

# Arguments
* `connection`:\\[in\\] The connection object
# Returns
the mqtt connection
### Prototype
```c
struct aws_mqtt_client_connection *aws_mqtt_client_connection_acquire(struct aws_mqtt_client_connection *connection);
```
"""
function aws_mqtt_client_connection_acquire(connection)
    ccall((:aws_mqtt_client_connection_acquire, libaws_c_mqtt), Ptr{aws_mqtt_client_connection}, (Ptr{aws_mqtt_client_connection},), connection)
end

"""
    aws_mqtt_client_connection_release(connection)

Decrements the ref count on an mqtt connection. If the ref count drops to zero, the connection is cleaned up. Note: cannot call this with lock held, since it will start the destroy process and cause a dead lock.

# Arguments
* `connection`:\\[in\\] The connection object
### Prototype
```c
void aws_mqtt_client_connection_release(struct aws_mqtt_client_connection *connection);
```
"""
function aws_mqtt_client_connection_release(connection)
    ccall((:aws_mqtt_client_connection_release, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt_client_connection},), connection)
end

"""
    aws_mqtt_client_connection_set_will(connection, topic, qos, retain, payload)

Sets the will message to send with the CONNECT packet.

# Arguments
* `connection`:\\[in\\] The connection object
* `topic`:\\[in\\] The topic to publish the will on
* `qos`:\\[in\\] The QoS to publish the will with
* `retain`:\\[in\\] The retain flag to publish the will with
* `payload`:\\[in\\] The data if the will message
### Prototype
```c
int aws_mqtt_client_connection_set_will( struct aws_mqtt_client_connection *connection, const struct aws_byte_cursor *topic, enum aws_mqtt_qos qos, bool retain, const struct aws_byte_cursor *payload);
```
"""
function aws_mqtt_client_connection_set_will(connection, topic, qos, retain, payload)
    ccall((:aws_mqtt_client_connection_set_will, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_byte_cursor}, aws_mqtt_qos, Bool, Ptr{aws_byte_cursor}), connection, topic, qos, retain, payload)
end

"""
    aws_mqtt_client_connection_set_login(connection, username, password)

Sets the username and/or password to send with the CONNECT packet.

# Arguments
* `connection`:\\[in\\] The connection object
* `username`:\\[in\\] The username to connect with
* `password`:\\[in\\] [optional] The password to connect with
### Prototype
```c
int aws_mqtt_client_connection_set_login( struct aws_mqtt_client_connection *connection, const struct aws_byte_cursor *username, const struct aws_byte_cursor *password);
```
"""
function aws_mqtt_client_connection_set_login(connection, username, password)
    ccall((:aws_mqtt_client_connection_set_login, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_byte_cursor}, Ptr{aws_byte_cursor}), connection, username, password)
end

"""
    aws_mqtt_client_connection_use_websockets(connection, transformer, transformer_ud, validator, validator_ud)

Use MQTT over websockets when connecting. Requires the MQTT\\_WITH\\_WEBSOCKETS build option.

In this scenario, an HTTP connection is established, which is then upgraded to a websocket connection, which is then used to send MQTT data.

# Arguments
* `connection`:\\[in\\] The connection object.
* `transformer`:\\[in\\] [optional] Function that may transform the websocket handshake request. See [`aws_mqtt_transform_websocket_handshake_fn`](@ref) for more info.
* `transformer_ud`:\\[in\\] [optional] Userdata for request\\_transformer.
* `validator`:\\[in\\] [optional] Function that may reject the websocket handshake response.
* `validator_ud`:\\[in\\] [optional] Userdata for response\\_validator.
### Prototype
```c
int aws_mqtt_client_connection_use_websockets( struct aws_mqtt_client_connection *connection, aws_mqtt_transform_websocket_handshake_fn *transformer, void *transformer_ud, aws_mqtt_validate_websocket_handshake_fn *validator, void *validator_ud);
```
"""
function aws_mqtt_client_connection_use_websockets(connection, transformer, transformer_ud, validator, validator_ud)
    ccall((:aws_mqtt_client_connection_use_websockets, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_transform_websocket_handshake_fn}, Ptr{Cvoid}, Ptr{aws_mqtt_validate_websocket_handshake_fn}, Ptr{Cvoid}), connection, transformer, transformer_ud, validator, validator_ud)
end

"""
    aws_mqtt_client_connection_set_http_proxy_options(connection, proxy_options)

Set http proxy options for the connection.

### Prototype
```c
int aws_mqtt_client_connection_set_http_proxy_options( struct aws_mqtt_client_connection *connection, struct aws_http_proxy_options *proxy_options);
```
"""
function aws_mqtt_client_connection_set_http_proxy_options(connection, proxy_options)
    ccall((:aws_mqtt_client_connection_set_http_proxy_options, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_http_proxy_options}), connection, proxy_options)
end

"""
    aws_mqtt_client_connection_set_host_resolution_options(connection, host_resolution_config)

Set host resolution ooptions for the connection.

### Prototype
```c
int aws_mqtt_client_connection_set_host_resolution_options( struct aws_mqtt_client_connection *connection, const struct aws_host_resolution_config *host_resolution_config);
```
"""
function aws_mqtt_client_connection_set_host_resolution_options(connection, host_resolution_config)
    ccall((:aws_mqtt_client_connection_set_host_resolution_options, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_host_resolution_config}), connection, host_resolution_config)
end

"""
    aws_mqtt_client_connection_set_reconnect_timeout(connection, min_timeout, max_timeout)

Sets the minimum and maximum reconnect timeouts.

The time between reconnect attempts will start at min and multiply by 2 until max is reached.

# Arguments
* `connection`:\\[in\\] The connection object
* `min_timeout`:\\[in\\] The timeout to start with
* `max_timeout`:\\[in\\] The highest allowable wait time between reconnect attempts
### Prototype
```c
int aws_mqtt_client_connection_set_reconnect_timeout( struct aws_mqtt_client_connection *connection, uint64_t min_timeout, uint64_t max_timeout);
```
"""
function aws_mqtt_client_connection_set_reconnect_timeout(connection, min_timeout, max_timeout)
    ccall((:aws_mqtt_client_connection_set_reconnect_timeout, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, UInt64, UInt64), connection, min_timeout, max_timeout)
end

"""
    aws_mqtt_client_connection_set_connection_result_handlers(connection, on_connection_success, on_connection_success_ud, on_connection_failure, on_connection_failure_ud)

Sets the callbacks to call when a connection succeeds or fails

# Arguments
* `connection`:\\[in\\] The connection object
* `on_connection_success`:\\[in\\] The function to call when a connection is successful or gets resumed
* `on_connection_success_ud`:\\[in\\] Userdata for on\\_connection\\_success
* `on_connection_failure`:\\[in\\] The function to call when a connection fails
* `on_connection_failure_ud`:\\[in\\] Userdata for on\\_connection\\_failure
### Prototype
```c
int aws_mqtt_client_connection_set_connection_result_handlers( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_connection_success_fn *on_connection_success, void *on_connection_success_ud, aws_mqtt_client_on_connection_failure_fn *on_connection_failure, void *on_connection_failure_ud);
```
"""
function aws_mqtt_client_connection_set_connection_result_handlers(connection, on_connection_success, on_connection_success_ud, on_connection_failure, on_connection_failure_ud)
    ccall((:aws_mqtt_client_connection_set_connection_result_handlers, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_connection_success_fn}, Ptr{Cvoid}, Ptr{aws_mqtt_client_on_connection_failure_fn}, Ptr{Cvoid}), connection, on_connection_success, on_connection_success_ud, on_connection_failure, on_connection_failure_ud)
end

"""
    aws_mqtt_client_connection_set_connection_interruption_handlers(connection, on_interrupted, on_interrupted_ud, on_resumed, on_resumed_ud)

Sets the callbacks to call when a connection is interrupted and resumed.

# Arguments
* `connection`:\\[in\\] The connection object
* `on_interrupted`:\\[in\\] The function to call when a connection is lost
* `on_interrupted_ud`:\\[in\\] Userdata for on\\_interrupted
* `on_resumed`:\\[in\\] The function to call when a connection is resumed (if clean\\_session is true, calling [`aws_mqtt_resubscribe_existing_topics`](@ref) is suggested)
* `on_resumed_ud`:\\[in\\] Userdata for on\\_resumed
### Prototype
```c
int aws_mqtt_client_connection_set_connection_interruption_handlers( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_connection_interrupted_fn *on_interrupted, void *on_interrupted_ud, aws_mqtt_client_on_connection_resumed_fn *on_resumed, void *on_resumed_ud);
```
"""
function aws_mqtt_client_connection_set_connection_interruption_handlers(connection, on_interrupted, on_interrupted_ud, on_resumed, on_resumed_ud)
    ccall((:aws_mqtt_client_connection_set_connection_interruption_handlers, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_connection_interrupted_fn}, Ptr{Cvoid}, Ptr{aws_mqtt_client_on_connection_resumed_fn}, Ptr{Cvoid}), connection, on_interrupted, on_interrupted_ud, on_resumed, on_resumed_ud)
end

"""
    aws_mqtt_client_connection_set_connection_closed_handler(connection, on_closed, on_closed_ud)

Sets the callback to call when the connection is closed normally by user request. This is different than the connection interrupted or lost, this only covers successful closure.

# Arguments
* `connection`:\\[in\\] The connection object
* `on_closed`:\\[in\\] The function to call when a connection is closed
* `on_closed_ud`:\\[in\\] Userdata for on\\_closed
### Prototype
```c
int aws_mqtt_client_connection_set_connection_closed_handler( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_connection_closed_fn *on_closed, void *on_closed_ud);
```
"""
function aws_mqtt_client_connection_set_connection_closed_handler(connection, on_closed, on_closed_ud)
    ccall((:aws_mqtt_client_connection_set_connection_closed_handler, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_connection_closed_fn}, Ptr{Cvoid}), connection, on_closed, on_closed_ud)
end

"""
    aws_mqtt_client_connection_set_on_any_publish_handler(connection, on_any_publish, on_any_publish_ud)

Sets the callback to call whenever ANY publish packet is received. Only safe to set when connection is not connected.

# Arguments
* `connection`:\\[in\\] The connection object
* `on_any_publish`:\\[in\\] The function to call when a publish is received (pass NULL to unset)
* `on_any_publish_ud`:\\[in\\] Userdata for on\\_any\\_publish
### Prototype
```c
int aws_mqtt_client_connection_set_on_any_publish_handler( struct aws_mqtt_client_connection *connection, aws_mqtt_client_publish_received_fn *on_any_publish, void *on_any_publish_ud);
```
"""
function aws_mqtt_client_connection_set_on_any_publish_handler(connection, on_any_publish, on_any_publish_ud)
    ccall((:aws_mqtt_client_connection_set_on_any_publish_handler, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_publish_received_fn}, Ptr{Cvoid}), connection, on_any_publish, on_any_publish_ud)
end

"""
    aws_mqtt_client_connection_set_connection_termination_handler(connection, on_termination, on_termination_ud)

Sets the callback to call on a connection destruction.

# Arguments
* `connection`:\\[in\\] The connection object.
* `on_termination`:\\[in\\] The function to call when a connection is destroyed.
* `on_termination_ud`:\\[in\\] Userdata for on\\_termination.
### Prototype
```c
int aws_mqtt_client_connection_set_connection_termination_handler( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_connection_termination_fn *on_termination, void *on_termination_ud);
```
"""
function aws_mqtt_client_connection_set_connection_termination_handler(connection, on_termination, on_termination_ud)
    ccall((:aws_mqtt_client_connection_set_connection_termination_handler, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_connection_termination_fn}, Ptr{Cvoid}), connection, on_termination, on_termination_ud)
end

"""
    aws_mqtt_client_connection_connect(connection, connection_options)

Opens the actual connection defined by [`aws_mqtt_client_connection_new`](@ref). Once the connection is opened, on\\_connack will be called. Only called when connection is disconnected.

# Arguments
* `connection`:\\[in\\] The connection object
* `connection_options`:\\[in\\] Configuration information for the connection attempt
# Returns
AWS\\_OP\\_SUCCESS if the connection has been successfully initiated, otherwise AWS\\_OP\\_ERR and aws\\_last\\_error() will be set.
### Prototype
```c
int aws_mqtt_client_connection_connect( struct aws_mqtt_client_connection *connection, const struct aws_mqtt_connection_options *connection_options);
```
"""
function aws_mqtt_client_connection_connect(connection, connection_options)
    ccall((:aws_mqtt_client_connection_connect, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_connection_options}), connection, connection_options)
end

"""
    aws_mqtt_client_connection_reconnect(connection, on_connection_complete, userdata)

DEPRECATED Opens the actual connection defined by [`aws_mqtt_client_connection_new`](@ref). Once the connection is opened, on\\_connack will be called.

Must be called on a connection that has previously been open, as the parameters passed during the last connection will be reused.

# Arguments
* `connection`:\\[in\\] The connection object
* `on_connection_complete`:\\[in\\] The callback to fire when the connection attempt completes
* `userdata`:\\[in\\] (nullable) Passed to the userdata param of on\\_connection\\_complete
# Returns
AWS\\_OP\\_SUCCESS if the connection has been successfully initiated, otherwise AWS\\_OP\\_ERR and aws\\_last\\_error() will be set.
### Prototype
```c
int aws_mqtt_client_connection_reconnect( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_connection_complete_fn *on_connection_complete, void *userdata);
```
"""
function aws_mqtt_client_connection_reconnect(connection, on_connection_complete, userdata)
    ccall((:aws_mqtt_client_connection_reconnect, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_connection_complete_fn}, Ptr{Cvoid}), connection, on_connection_complete, userdata)
end

"""
    aws_mqtt_client_connection_disconnect(connection, on_disconnect, userdata)

Closes the connection asynchronously, calls the on\\_disconnect callback. All uncompleted requests (publish/subscribe/unsubscribe) will be cancelled, regardless to the status of clean\\_session. DISCONNECT packet will be sent, which deletes the will message from server.

# Arguments
* `connection`:\\[in\\] The connection to close
* `on_disconnect`:\\[in\\] (nullable) Callback function to invoke when the connection is completely disconnected.
* `userdata`:\\[in\\] (nullable) passed to on\\_disconnect
# Returns
AWS\\_OP\\_SUCCESS if the connection is open and is being shutdown, otherwise AWS\\_OP\\_ERR and aws\\_last\\_error() is set.
### Prototype
```c
int aws_mqtt_client_connection_disconnect( struct aws_mqtt_client_connection *connection, aws_mqtt_client_on_disconnect_fn *on_disconnect, void *userdata);
```
"""
function aws_mqtt_client_connection_disconnect(connection, on_disconnect, userdata)
    ccall((:aws_mqtt_client_connection_disconnect, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_client_on_disconnect_fn}, Ptr{Cvoid}), connection, on_disconnect, userdata)
end

"""
    aws_mqtt_client_connection_subscribe_multiple(connection, topic_filters, on_suback, on_suback_ud)

Subscribe to topic filters. on\\_publish will be called when a PUBLISH matching each topic\\_filter is received.

# Arguments
* `connection`:\\[in\\] The connection to subscribe on
* `topic_filters`:\\[in\\] An array\\_list of [`aws_mqtt_topic_subscription`](@ref) (NOT pointers) describing the requests.
* `on_suback`:\\[in\\] (nullable) Called when a SUBACK has been received from the server and the subscription is complete. Broker may fail one of the topics, check the qos in [`aws_mqtt_topic_subscription`](@ref) from the callback
* `on_suback_ud`:\\[in\\] (nullable) Passed to on\\_suback
# Returns
The packet id of the subscribe packet if successfully sent, otherwise 0.
### Prototype
```c
uint16_t aws_mqtt_client_connection_subscribe_multiple( struct aws_mqtt_client_connection *connection, const struct aws_array_list *topic_filters, aws_mqtt_suback_multi_fn *on_suback, void *on_suback_ud);
```
"""
function aws_mqtt_client_connection_subscribe_multiple(connection, topic_filters, on_suback, on_suback_ud)
    ccall((:aws_mqtt_client_connection_subscribe_multiple, libaws_c_mqtt), UInt16, (Ptr{aws_mqtt_client_connection}, Ptr{aws_array_list}, Ptr{aws_mqtt_suback_multi_fn}, Ptr{Cvoid}), connection, topic_filters, on_suback, on_suback_ud)
end

"""
    aws_mqtt_client_connection_subscribe(connection, topic_filter, qos, on_publish, on_publish_ud, on_ud_cleanup, on_suback, on_suback_ud)

Subscribe to a single topic filter. on\\_publish will be called when a PUBLISH matching topic\\_filter is received.

# Arguments
* `connection`:\\[in\\] The connection to subscribe on
* `topic_filter`:\\[in\\] The topic filter to subscribe on. This resource must persist until on\\_suback.
* `qos`:\\[in\\] The maximum QoS of messages to receive
* `on_publish`:\\[in\\] (nullable) Called when a PUBLISH packet matching topic\\_filter is received
* `on_publish_ud`:\\[in\\] (nullable) Passed to on\\_publish
* `on_ud_cleanup`:\\[in\\] (nullable) Called when a subscription is removed, on\\_publish\\_ud is passed.
* `on_suback`:\\[in\\] (nullable) Called when a SUBACK has been received from the server and the subscription is complete
* `on_suback_ud`:\\[in\\] (nullable) Passed to on\\_suback
# Returns
The packet id of the subscribe packet if successfully sent, otherwise 0.
### Prototype
```c
uint16_t aws_mqtt_client_connection_subscribe( struct aws_mqtt_client_connection *connection, const struct aws_byte_cursor *topic_filter, enum aws_mqtt_qos qos, aws_mqtt_client_publish_received_fn *on_publish, void *on_publish_ud, aws_mqtt_userdata_cleanup_fn *on_ud_cleanup, aws_mqtt_suback_fn *on_suback, void *on_suback_ud);
```
"""
function aws_mqtt_client_connection_subscribe(connection, topic_filter, qos, on_publish, on_publish_ud, on_ud_cleanup, on_suback, on_suback_ud)
    ccall((:aws_mqtt_client_connection_subscribe, libaws_c_mqtt), UInt16, (Ptr{aws_mqtt_client_connection}, Ptr{aws_byte_cursor}, aws_mqtt_qos, Ptr{aws_mqtt_client_publish_received_fn}, Ptr{Cvoid}, Ptr{aws_mqtt_userdata_cleanup_fn}, Ptr{aws_mqtt_suback_fn}, Ptr{Cvoid}), connection, topic_filter, qos, on_publish, on_publish_ud, on_ud_cleanup, on_suback, on_suback_ud)
end

"""
    aws_mqtt_resubscribe_existing_topics(connection, on_suback, on_suback_ud)

Resubscribe to all topics currently subscribed to. This is to help when resuming a connection with a clean session.

# Arguments
* `connection`:\\[in\\] The connection to subscribe on
* `on_suback`:\\[in\\] (nullable) Called when a SUBACK has been received from the server and the subscription is complete
* `on_suback_ud`:\\[in\\] (nullable) Passed to on\\_suback
# Returns
The packet id of the subscribe packet if successfully sent, otherwise 0 (and aws\\_last\\_error() will be set).
### Prototype
```c
uint16_t aws_mqtt_resubscribe_existing_topics( struct aws_mqtt_client_connection *connection, aws_mqtt_suback_multi_fn *on_suback, void *on_suback_ud);
```
"""
function aws_mqtt_resubscribe_existing_topics(connection, on_suback, on_suback_ud)
    ccall((:aws_mqtt_resubscribe_existing_topics, libaws_c_mqtt), UInt16, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_suback_multi_fn}, Ptr{Cvoid}), connection, on_suback, on_suback_ud)
end

"""
    aws_mqtt_client_connection_unsubscribe(connection, topic_filter, on_unsuback, on_unsuback_ud)

Unsubscribe to a topic filter.

# Arguments
* `connection`:\\[in\\] The connection to unsubscribe on
* `topic_filter`:\\[in\\] The topic filter to unsubscribe on. This resource must persist until on\\_unsuback.
* `on_unsuback`:\\[in\\] (nullable) Called when a UNSUBACK has been received from the server and the subscription is removed
* `on_unsuback_ud`:\\[in\\] (nullable) Passed to on\\_unsuback
# Returns
The packet id of the unsubscribe packet if successfully sent, otherwise 0.
### Prototype
```c
uint16_t aws_mqtt_client_connection_unsubscribe( struct aws_mqtt_client_connection *connection, const struct aws_byte_cursor *topic_filter, aws_mqtt_op_complete_fn *on_unsuback, void *on_unsuback_ud);
```
"""
function aws_mqtt_client_connection_unsubscribe(connection, topic_filter, on_unsuback, on_unsuback_ud)
    ccall((:aws_mqtt_client_connection_unsubscribe, libaws_c_mqtt), UInt16, (Ptr{aws_mqtt_client_connection}, Ptr{aws_byte_cursor}, Ptr{aws_mqtt_op_complete_fn}, Ptr{Cvoid}), connection, topic_filter, on_unsuback, on_unsuback_ud)
end

"""
    aws_mqtt_client_connection_publish(connection, topic, qos, retain, payload, on_complete, userdata)

Send a PUBLISH packet over connection.

# Arguments
* `connection`:\\[in\\] The connection to publish on
* `topic`:\\[in\\] The topic to publish on
* `qos`:\\[in\\] The requested QoS of the packet
* `retain`:\\[in\\] True to have the server save the packet, and send to all new subscriptions matching topic
* `payload`:\\[in\\] The data to send as the payload of the publish
* `on_complete`:\\[in\\] (nullable) For QoS 0, called as soon as the packet is sent For QoS 1, called when PUBACK is received For QoS 2, called when PUBCOMP is received
* `user_data`:\\[in\\] (nullable) Passed to on\\_complete
# Returns
The packet id of the publish packet if successfully sent, otherwise 0.
### Prototype
```c
uint16_t aws_mqtt_client_connection_publish( struct aws_mqtt_client_connection *connection, const struct aws_byte_cursor *topic, enum aws_mqtt_qos qos, bool retain, const struct aws_byte_cursor *payload, aws_mqtt_op_complete_fn *on_complete, void *userdata);
```
"""
function aws_mqtt_client_connection_publish(connection, topic, qos, retain, payload, on_complete, userdata)
    ccall((:aws_mqtt_client_connection_publish, libaws_c_mqtt), UInt16, (Ptr{aws_mqtt_client_connection}, Ptr{aws_byte_cursor}, aws_mqtt_qos, Bool, Ptr{aws_byte_cursor}, Ptr{aws_mqtt_op_complete_fn}, Ptr{Cvoid}), connection, topic, qos, retain, payload, on_complete, userdata)
end

"""
    aws_mqtt_client_connection_get_stats(connection, stats)

Queries the connection's internal statistics for incomplete/unacked operations.

# Arguments
* `connection`: connection to get statistics for
* `stats`: set of incomplete/unacked operation statistics
# Returns
AWS\\_OP\\_SUCCESS if getting the operation statistics were successful, AWS\\_OP\\_ERR otherwise
### Prototype
```c
int aws_mqtt_client_connection_get_stats( struct aws_mqtt_client_connection *connection, struct aws_mqtt_connection_operation_statistics *stats);
```
"""
function aws_mqtt_client_connection_get_stats(connection, stats)
    ccall((:aws_mqtt_client_connection_get_stats, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, Ptr{aws_mqtt_connection_operation_statistics}), connection, stats)
end

"""
    aws_mqtt_connect_return_code

Documentation not found.
"""
@cenum aws_mqtt_connect_return_code::UInt32 begin
    AWS_MQTT_CONNECT_ACCEPTED = 0
    AWS_MQTT_CONNECT_UNACCEPTABLE_PROTOCOL_VERSION = 1
    AWS_MQTT_CONNECT_IDENTIFIER_REJECTED = 2
    AWS_MQTT_CONNECT_SERVER_UNAVAILABLE = 3
    AWS_MQTT_CONNECT_BAD_USERNAME_OR_PASSWORD = 4
    AWS_MQTT_CONNECT_NOT_AUTHORIZED = 5
end

"""
    aws_mqtt_error

Documentation not found.
"""
@cenum aws_mqtt_error::UInt32 begin
    AWS_ERROR_MQTT_INVALID_RESERVED_BITS = 5120
    AWS_ERROR_MQTT_BUFFER_TOO_BIG = 5121
    AWS_ERROR_MQTT_INVALID_REMAINING_LENGTH = 5122
    AWS_ERROR_MQTT_UNSUPPORTED_PROTOCOL_NAME = 5123
    AWS_ERROR_MQTT_UNSUPPORTED_PROTOCOL_LEVEL = 5124
    AWS_ERROR_MQTT_INVALID_CREDENTIALS = 5125
    AWS_ERROR_MQTT_INVALID_QOS = 5126
    AWS_ERROR_MQTT_INVALID_PACKET_TYPE = 5127
    AWS_ERROR_MQTT_INVALID_TOPIC = 5128
    AWS_ERROR_MQTT_TIMEOUT = 5129
    AWS_ERROR_MQTT_PROTOCOL_ERROR = 5130
    AWS_ERROR_MQTT_NOT_CONNECTED = 5131
    AWS_ERROR_MQTT_ALREADY_CONNECTED = 5132
    AWS_ERROR_MQTT_BUILT_WITHOUT_WEBSOCKETS = 5133
    AWS_ERROR_MQTT_UNEXPECTED_HANGUP = 5134
    AWS_ERROR_MQTT_CONNECTION_SHUTDOWN = 5135
    AWS_ERROR_MQTT_CONNECTION_DESTROYED = 5136
    AWS_ERROR_MQTT_CONNECTION_DISCONNECTING = 5137
    AWS_ERROR_MQTT_CANCELLED_FOR_CLEAN_SESSION = 5138
    AWS_ERROR_MQTT_QUEUE_FULL = 5139
    AWS_ERROR_MQTT5_CLIENT_OPTIONS_VALIDATION = 5140
    AWS_ERROR_MQTT5_CONNECT_OPTIONS_VALIDATION = 5141
    AWS_ERROR_MQTT5_DISCONNECT_OPTIONS_VALIDATION = 5142
    AWS_ERROR_MQTT5_PUBLISH_OPTIONS_VALIDATION = 5143
    AWS_ERROR_MQTT5_SUBSCRIBE_OPTIONS_VALIDATION = 5144
    AWS_ERROR_MQTT5_UNSUBSCRIBE_OPTIONS_VALIDATION = 5145
    AWS_ERROR_MQTT5_USER_PROPERTY_VALIDATION = 5146
    AWS_ERROR_MQTT5_PACKET_VALIDATION = 5147
    AWS_ERROR_MQTT5_ENCODE_FAILURE = 5148
    AWS_ERROR_MQTT5_DECODE_PROTOCOL_ERROR = 5149
    AWS_ERROR_MQTT5_CONNACK_CONNECTION_REFUSED = 5150
    AWS_ERROR_MQTT5_CONNACK_TIMEOUT = 5151
    AWS_ERROR_MQTT5_PING_RESPONSE_TIMEOUT = 5152
    AWS_ERROR_MQTT5_USER_REQUESTED_STOP = 5153
    AWS_ERROR_MQTT5_DISCONNECT_RECEIVED = 5154
    AWS_ERROR_MQTT5_CLIENT_TERMINATED = 5155
    AWS_ERROR_MQTT5_OPERATION_FAILED_DUE_TO_OFFLINE_QUEUE_POLICY = 5156
    AWS_ERROR_MQTT5_ENCODE_SIZE_UNSUPPORTED_PACKET_TYPE = 5157
    AWS_ERROR_MQTT5_OPERATION_PROCESSING_FAILURE = 5158
    AWS_ERROR_MQTT5_INVALID_INBOUND_TOPIC_ALIAS = 5159
    AWS_ERROR_MQTT5_INVALID_OUTBOUND_TOPIC_ALIAS = 5160
    AWS_ERROR_MQTT5_INVALID_UTF8_STRING = 5161
    AWS_ERROR_MQTT_CONNECTION_RESET_FOR_ADAPTER_CONNECT = 5162
    AWS_ERROR_MQTT_CONNECTION_RESUBSCRIBE_NO_TOPICS = 5163
    AWS_ERROR_MQTT_CONNECTION_SUBSCRIBE_FAILURE = 5164
    AWS_ERROR_MQTT_ACK_REASON_CODE_FAILURE = 5165
    AWS_ERROR_END_MQTT_RANGE = 6143
end

"""
    aws_mqtt_log_subject

Documentation not found.
"""
@cenum aws_mqtt_log_subject::UInt32 begin
    AWS_LS_MQTT_GENERAL = 5120
    AWS_LS_MQTT_CLIENT = 5121
    AWS_LS_MQTT_TOPIC_TREE = 5122
    AWS_LS_MQTT5_GENERAL = 5123
    AWS_LS_MQTT5_CLIENT = 5124
    AWS_LS_MQTT5_CANARY = 5125
    AWS_LS_MQTT5_TO_MQTT3_ADAPTER = 5126
end

"""
    aws_mqtt_is_valid_topic(topic)

Documentation not found.
### Prototype
```c
bool aws_mqtt_is_valid_topic(const struct aws_byte_cursor *topic);
```
"""
function aws_mqtt_is_valid_topic(topic)
    ccall((:aws_mqtt_is_valid_topic, libaws_c_mqtt), Bool, (Ptr{aws_byte_cursor},), topic)
end

"""
    aws_mqtt_is_valid_topic_filter(topic_filter)

Documentation not found.
### Prototype
```c
bool aws_mqtt_is_valid_topic_filter(const struct aws_byte_cursor *topic_filter);
```
"""
function aws_mqtt_is_valid_topic_filter(topic_filter)
    ccall((:aws_mqtt_is_valid_topic_filter, libaws_c_mqtt), Bool, (Ptr{aws_byte_cursor},), topic_filter)
end

"""
    aws_mqtt_validate_utf8_text(text)

Validate utf-8 string under mqtt specs

# Arguments
* `text`:
# Returns
AWS\\_OP\\_SUCCESS if the text is validate, otherwise AWS\\_OP\\_ERR
### Prototype
```c
int aws_mqtt_validate_utf8_text(struct aws_byte_cursor text);
```
"""
function aws_mqtt_validate_utf8_text(text)
    ccall((:aws_mqtt_validate_utf8_text, libaws_c_mqtt), Cint, (aws_byte_cursor,), text)
end

"""
    aws_mqtt_library_init(allocator)

Initializes internal datastructures used by aws-c-mqtt. Must be called before using any functionality in aws-c-mqtt.

### Prototype
```c
void aws_mqtt_library_init(struct aws_allocator *allocator);
```
"""
function aws_mqtt_library_init(allocator)
    ccall((:aws_mqtt_library_init, libaws_c_mqtt), Cvoid, (Ptr{aws_allocator},), allocator)
end

"""
    aws_mqtt_library_clean_up()

Shuts down the internal datastructures used by aws-c-mqtt.

### Prototype
```c
void aws_mqtt_library_clean_up(void);
```
"""
function aws_mqtt_library_clean_up()
    ccall((:aws_mqtt_library_clean_up, libaws_c_mqtt), Cvoid, ())
end

"""
    aws_mqtt_fatal_assert_library_initialized()

Documentation not found.
### Prototype
```c
void aws_mqtt_fatal_assert_library_initialized(void);
```
"""
function aws_mqtt_fatal_assert_library_initialized()
    ccall((:aws_mqtt_fatal_assert_library_initialized, libaws_c_mqtt), Cvoid, ())
end

"""
Documentation not found.
"""
mutable struct aws_mqtt_client_connection_311_impl end

"""
    aws_mqtt_client_get_payload_for_outstanding_publish_packet(connection, packet_id, allocator, result)

result buffer will be initialized and payload will be written into it

### Prototype
```c
int aws_mqtt_client_get_payload_for_outstanding_publish_packet( struct aws_mqtt_client_connection *connection, uint16_t packet_id, struct aws_allocator *allocator, struct aws_byte_buf *result);
```
"""
function aws_mqtt_client_get_payload_for_outstanding_publish_packet(connection, packet_id, allocator, result)
    ccall((:aws_mqtt_client_get_payload_for_outstanding_publish_packet, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, UInt16, Ptr{aws_allocator}, Ptr{aws_byte_buf}), connection, packet_id, allocator, result)
end

"""
    aws_mqtt_client_get_topic_for_outstanding_publish_packet(connection, packet_id, allocator, result)

Documentation not found.
### Prototype
```c
int aws_mqtt_client_get_topic_for_outstanding_publish_packet( struct aws_mqtt_client_connection *connection, uint16_t packet_id, struct aws_allocator *allocator, struct aws_string **result);
```
"""
function aws_mqtt_client_get_topic_for_outstanding_publish_packet(connection, packet_id, allocator, result)
    ccall((:aws_mqtt_client_get_topic_for_outstanding_publish_packet, libaws_c_mqtt), Cint, (Ptr{aws_mqtt_client_connection}, UInt16, Ptr{aws_allocator}, Ptr{Ptr{aws_string}}), connection, packet_id, allocator, result)
end

"""
    aws_mqtt5_client_session_behavior_type

Controls how the mqtt client should behave with respect to mqtt sessions.
"""
@cenum aws_mqtt5_client_session_behavior_type::UInt32 begin
    AWS_MQTT5_CSBT_DEFAULT = 0
    AWS_MQTT5_CSBT_CLEAN = 1
    AWS_MQTT5_CSBT_REJOIN_POST_SUCCESS = 2
    AWS_MQTT5_CSBT_REJOIN_ALWAYS = 3
end

"""
    aws_mqtt5_client_outbound_topic_alias_behavior_type

Outbound topic aliasing behavior is controlled by this type.

Topic alias behavior is described in https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901113

If the server allows topic aliasing, this setting controls how topic aliases are used on PUBLISH packets sent from the client to the server.

If topic aliasing is not supported by the server, this setting has no effect and any attempts to directly manipulate the topic alias id in outbound publishes will be ignored.
"""
@cenum aws_mqtt5_client_outbound_topic_alias_behavior_type::UInt32 begin
    AWS_MQTT5_COTABT_DEFAULT = 0
    AWS_MQTT5_COTABT_MANUAL = 1
    AWS_MQTT5_COTABT_LRU = 2
    AWS_MQTT5_COTABT_DISABLED = 3
end

"""
    aws_mqtt5_client_inbound_topic_alias_behavior_type

Inbound topic aliasing behavior is controlled by this type.

Topic alias behavior is described in https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901113

This setting controls whether or not the client will send a positive topic alias maximum to the server in its CONNECT packets.

If topic aliasing is not supported by the server, this setting has no net effect.
"""
@cenum aws_mqtt5_client_inbound_topic_alias_behavior_type::UInt32 begin
    AWS_MQTT5_CITABT_DEFAULT = 0
    AWS_MQTT5_CITABT_ENABLED = 1
    AWS_MQTT5_CITABT_DISABLED = 2
end

"""
    aws_mqtt5_client_topic_alias_options

Configuration struct for all client topic aliasing behavior. If this is left null, then all default options (as it zeroed) will be used.
"""
struct aws_mqtt5_client_topic_alias_options
    outbound_topic_alias_behavior::aws_mqtt5_client_outbound_topic_alias_behavior_type
    outbound_alias_cache_max_size::UInt16
    inbound_topic_alias_behavior::aws_mqtt5_client_inbound_topic_alias_behavior_type
    inbound_alias_cache_size::UInt16
end

"""
    aws_mqtt5_extended_validation_and_flow_control_options

Extended validation and flow control options

Potentially a point of expansion in the future. We could add custom controls letting people override the Aws IOT Core limits based on their account properties. We could, with IoT Core support, add dynamic limit recognition via user properties as well.
"""
@cenum aws_mqtt5_extended_validation_and_flow_control_options::UInt32 begin
    AWS_MQTT5_EVAFCO_NONE = 0
    AWS_MQTT5_EVAFCO_AWS_IOT_CORE_DEFAULTS = 1
end

"""
    aws_mqtt5_client_operation_queue_behavior_type

Controls how disconnects affect the queued and in-progress operations submitted to the client. Also controls how operations are handled while the client is not connected. In particular, if the client is not connected, then any operation that would be failed on disconnect (according to these rules) will be rejected.
"""
@cenum aws_mqtt5_client_operation_queue_behavior_type::UInt32 begin
    AWS_MQTT5_COQBT_DEFAULT = 0
    AWS_MQTT5_COQBT_FAIL_NON_QOS1_PUBLISH_ON_DISCONNECT = 1
    AWS_MQTT5_COQBT_FAIL_QOS0_PUBLISH_ON_DISCONNECT = 2
    AWS_MQTT5_COQBT_FAIL_ALL_ON_DISCONNECT = 3
end

"""
    aws_mqtt5_client_lifecycle_event_type

Type of a client lifecycle event
"""
@cenum aws_mqtt5_client_lifecycle_event_type::UInt32 begin
    AWS_MQTT5_CLET_ATTEMPTING_CONNECT = 0
    AWS_MQTT5_CLET_CONNECTION_SUCCESS = 1
    AWS_MQTT5_CLET_CONNECTION_FAILURE = 2
    AWS_MQTT5_CLET_DISCONNECTION = 3
    AWS_MQTT5_CLET_STOPPED = 4
end

# typedef void ( aws_mqtt5_transform_websocket_handshake_complete_fn ) ( struct aws_http_message * request , int error_code , void * complete_ctx )
"""
Signature of the continuation function to be called after user-code transforms a websocket handshake request
"""
const aws_mqtt5_transform_websocket_handshake_complete_fn = Cvoid

# typedef void ( aws_mqtt5_transform_websocket_handshake_fn ) ( struct aws_http_message * request , void * user_data , aws_mqtt5_transform_websocket_handshake_complete_fn * complete_fn , void * complete_ctx )
"""
Signature of the websocket handshake request transformation function. After transformation, the completion function must be invoked to send the request.
"""
const aws_mqtt5_transform_websocket_handshake_fn = Cvoid

# typedef void ( aws_mqtt5_client_connection_event_callback_fn ) ( const struct aws_mqtt5_client_lifecycle_event * event )
"""
Callback signature for mqtt5 client lifecycle events.
"""
const aws_mqtt5_client_connection_event_callback_fn = Cvoid

# typedef void ( aws_mqtt5_publish_completion_fn ) ( enum aws_mqtt5_packet_type packet_type , const void * packet , int error_code , void * complete_ctx )
"""
Signature of callback to invoke on Publish success/failure.
"""
const aws_mqtt5_publish_completion_fn = Cvoid

# typedef void ( aws_mqtt5_subscribe_completion_fn ) ( const struct aws_mqtt5_packet_suback_view * suback , int error_code , void * complete_ctx )
"""
Signature of callback to invoke on Subscribe success/failure.
"""
const aws_mqtt5_subscribe_completion_fn = Cvoid

# typedef void ( aws_mqtt5_unsubscribe_completion_fn ) ( const struct aws_mqtt5_packet_unsuback_view * unsuback , int error_code , void * complete_ctx )
"""
Signature of callback to invoke on Unsubscribe success/failure.
"""
const aws_mqtt5_unsubscribe_completion_fn = Cvoid

# typedef void ( aws_mqtt5_publish_received_fn ) ( const struct aws_mqtt5_packet_publish_view * publish , void * user_data )
"""
Signature of callback to invoke on Publish received
"""
const aws_mqtt5_publish_received_fn = Cvoid

# typedef bool ( aws_mqtt5_listener_publish_received_fn ) ( const struct aws_mqtt5_packet_publish_view * publish , void * user_data )
"""
Signature of a listener publish received callback that returns an indicator whether or not the publish was handled by the listener.
"""
const aws_mqtt5_listener_publish_received_fn = Cvoid

# typedef void ( aws_mqtt5_disconnect_completion_fn ) ( int error_code , void * complete_ctx )
"""
Signature of callback to invoke when a DISCONNECT is fully written to the socket (or fails to be)
"""
const aws_mqtt5_disconnect_completion_fn = Cvoid

# typedef void ( aws_mqtt5_client_termination_completion_fn ) ( void * complete_ctx )
"""
Signature of callback invoked when a client has completely destroyed itself
"""
const aws_mqtt5_client_termination_completion_fn = Cvoid

"""
    aws_mqtt5_publish_completion_options

Completion options for the Publish operation
"""
struct aws_mqtt5_publish_completion_options
    completion_callback::Ptr{aws_mqtt5_publish_completion_fn}
    completion_user_data::Ptr{Cvoid}
    ack_timeout_seconds_override::UInt32
end

"""
    aws_mqtt5_subscribe_completion_options

Completion options for the Subscribe operation
"""
struct aws_mqtt5_subscribe_completion_options
    completion_callback::Ptr{aws_mqtt5_subscribe_completion_fn}
    completion_user_data::Ptr{Cvoid}
    ack_timeout_seconds_override::UInt32
end

"""
    aws_mqtt5_unsubscribe_completion_options

Completion options for the Unsubscribe operation
"""
struct aws_mqtt5_unsubscribe_completion_options
    completion_callback::Ptr{aws_mqtt5_unsubscribe_completion_fn}
    completion_user_data::Ptr{Cvoid}
    ack_timeout_seconds_override::UInt32
end

"""
    aws_mqtt5_disconnect_completion_options

Completion options for the a DISCONNECT operation
"""
struct aws_mqtt5_disconnect_completion_options
    completion_callback::Ptr{aws_mqtt5_disconnect_completion_fn}
    completion_user_data::Ptr{Cvoid}
end

"""
    aws_mqtt5_qos

MQTT Message delivery quality of service. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901234
"""
@cenum aws_mqtt5_qos::UInt32 begin
    AWS_MQTT5_QOS_AT_MOST_ONCE = 0
    AWS_MQTT5_QOS_AT_LEAST_ONCE = 1
    AWS_MQTT5_QOS_EXACTLY_ONCE = 2
end

"""
    aws_mqtt5_negotiated_settings

Mqtt behavior settings that are dynamically negotiated as part of the CONNECT/CONNACK exchange.
"""
struct aws_mqtt5_negotiated_settings
    maximum_qos::aws_mqtt5_qos
    session_expiry_interval::UInt32
    receive_maximum_from_server::UInt16
    maximum_packet_size_to_server::UInt32
    topic_alias_maximum_to_server::UInt16
    topic_alias_maximum_to_client::UInt16
    server_keep_alive::UInt16
    retain_available::Bool
    wildcard_subscriptions_available::Bool
    subscription_identifiers_available::Bool
    shared_subscriptions_available::Bool
    rejoined_session::Bool
    client_id_storage::aws_byte_buf
end

"""
    aws_mqtt5_client_operation_statistics

Contains some simple statistics about the current state of the client's queue of operations
"""
struct aws_mqtt5_client_operation_statistics
    incomplete_operation_count::UInt64
    incomplete_operation_size::UInt64
    unacked_operation_count::UInt64
    unacked_operation_size::UInt64
end

"""
    aws_mqtt5_connect_reason_code

Server return code for CONNECT attempts. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901079
"""
@cenum aws_mqtt5_connect_reason_code::UInt32 begin
    AWS_MQTT5_CRC_SUCCESS = 0
    AWS_MQTT5_CRC_UNSPECIFIED_ERROR = 128
    AWS_MQTT5_CRC_MALFORMED_PACKET = 129
    AWS_MQTT5_CRC_PROTOCOL_ERROR = 130
    AWS_MQTT5_CRC_IMPLEMENTATION_SPECIFIC_ERROR = 131
    AWS_MQTT5_CRC_UNSUPPORTED_PROTOCOL_VERSION = 132
    AWS_MQTT5_CRC_CLIENT_IDENTIFIER_NOT_VALID = 133
    AWS_MQTT5_CRC_BAD_USERNAME_OR_PASSWORD = 134
    AWS_MQTT5_CRC_NOT_AUTHORIZED = 135
    AWS_MQTT5_CRC_SERVER_UNAVAILABLE = 136
    AWS_MQTT5_CRC_SERVER_BUSY = 137
    AWS_MQTT5_CRC_BANNED = 138
    AWS_MQTT5_CRC_BAD_AUTHENTICATION_METHOD = 140
    AWS_MQTT5_CRC_TOPIC_NAME_INVALID = 144
    AWS_MQTT5_CRC_PACKET_TOO_LARGE = 149
    AWS_MQTT5_CRC_QUOTA_EXCEEDED = 151
    AWS_MQTT5_CRC_PAYLOAD_FORMAT_INVALID = 153
    AWS_MQTT5_CRC_RETAIN_NOT_SUPPORTED = 154
    AWS_MQTT5_CRC_QOS_NOT_SUPPORTED = 155
    AWS_MQTT5_CRC_USE_ANOTHER_SERVER = 156
    AWS_MQTT5_CRC_SERVER_MOVED = 157
    AWS_MQTT5_CRC_CONNECTION_RATE_EXCEEDED = 159
end

"""
    aws_mqtt5_user_property

Non-persistent representation of an mqtt5 user property.
"""
struct aws_mqtt5_user_property
    name::aws_byte_cursor
    value::aws_byte_cursor
end

"""
    aws_mqtt5_packet_connack_view

Read-only snapshot of a CONNACK packet.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901074
"""
struct aws_mqtt5_packet_connack_view
    session_present::Bool
    reason_code::aws_mqtt5_connect_reason_code
    session_expiry_interval::Ptr{UInt32}
    receive_maximum::Ptr{UInt16}
    maximum_qos::Ptr{aws_mqtt5_qos}
    retain_available::Ptr{Bool}
    maximum_packet_size::Ptr{UInt32}
    assigned_client_identifier::Ptr{aws_byte_cursor}
    topic_alias_maximum::Ptr{UInt16}
    reason_string::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
    wildcard_subscriptions_available::Ptr{Bool}
    subscription_identifiers_available::Ptr{Bool}
    shared_subscriptions_available::Ptr{Bool}
    server_keep_alive::Ptr{UInt16}
    response_information::Ptr{aws_byte_cursor}
    server_reference::Ptr{aws_byte_cursor}
    authentication_method::Ptr{aws_byte_cursor}
    authentication_data::Ptr{aws_byte_cursor}
end

"""
    aws_mqtt5_disconnect_reason_code

Reason code inside DISCONNECT packets. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901208
"""
@cenum aws_mqtt5_disconnect_reason_code::UInt32 begin
    AWS_MQTT5_DRC_NORMAL_DISCONNECTION = 0
    AWS_MQTT5_DRC_DISCONNECT_WITH_WILL_MESSAGE = 4
    AWS_MQTT5_DRC_UNSPECIFIED_ERROR = 128
    AWS_MQTT5_DRC_MALFORMED_PACKET = 129
    AWS_MQTT5_DRC_PROTOCOL_ERROR = 130
    AWS_MQTT5_DRC_IMPLEMENTATION_SPECIFIC_ERROR = 131
    AWS_MQTT5_DRC_NOT_AUTHORIZED = 135
    AWS_MQTT5_DRC_SERVER_BUSY = 137
    AWS_MQTT5_DRC_SERVER_SHUTTING_DOWN = 139
    AWS_MQTT5_DRC_KEEP_ALIVE_TIMEOUT = 141
    AWS_MQTT5_DRC_SESSION_TAKEN_OVER = 142
    AWS_MQTT5_DRC_TOPIC_FILTER_INVALID = 143
    AWS_MQTT5_DRC_TOPIC_NAME_INVALID = 144
    AWS_MQTT5_DRC_RECEIVE_MAXIMUM_EXCEEDED = 147
    AWS_MQTT5_DRC_TOPIC_ALIAS_INVALID = 148
    AWS_MQTT5_DRC_PACKET_TOO_LARGE = 149
    AWS_MQTT5_DRC_MESSAGE_RATE_TOO_HIGH = 150
    AWS_MQTT5_DRC_QUOTA_EXCEEDED = 151
    AWS_MQTT5_DRC_ADMINISTRATIVE_ACTION = 152
    AWS_MQTT5_DRC_PAYLOAD_FORMAT_INVALID = 153
    AWS_MQTT5_DRC_RETAIN_NOT_SUPPORTED = 154
    AWS_MQTT5_DRC_QOS_NOT_SUPPORTED = 155
    AWS_MQTT5_DRC_USE_ANOTHER_SERVER = 156
    AWS_MQTT5_DRC_SERVER_MOVED = 157
    AWS_MQTT5_DRC_SHARED_SUBSCRIPTIONS_NOT_SUPPORTED = 158
    AWS_MQTT5_DRC_CONNECTION_RATE_EXCEEDED = 159
    AWS_MQTT5_DRC_MAXIMUM_CONNECT_TIME = 160
    AWS_MQTT5_DRC_SUBSCRIPTION_IDENTIFIERS_NOT_SUPPORTED = 161
    AWS_MQTT5_DRC_WILDCARD_SUBSCRIPTIONS_NOT_SUPPORTED = 162
end

"""
    aws_mqtt5_packet_disconnect_view

Read-only snapshot of a DISCONNECT packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901205
"""
struct aws_mqtt5_packet_disconnect_view
    reason_code::aws_mqtt5_disconnect_reason_code
    session_expiry_interval_seconds::Ptr{UInt32}
    reason_string::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
    server_reference::Ptr{aws_byte_cursor}
end

"""
    aws_mqtt5_client_lifecycle_event

Details about a client lifecycle event.
"""
struct aws_mqtt5_client_lifecycle_event
    event_type::aws_mqtt5_client_lifecycle_event_type
    client::Ptr{aws_mqtt5_client}
    error_code::Cint
    user_data::Ptr{Cvoid}
    connack_data::Ptr{aws_mqtt5_packet_connack_view}
    settings::Ptr{aws_mqtt5_negotiated_settings}
    disconnect_data::Ptr{aws_mqtt5_packet_disconnect_view}
end

"""
Over-the-wire packet id as defined in the mqtt spec. Allocated at the point in time when the packet is is next to go down the channel and about to be encoded into an io message buffer.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901026
"""
const aws_mqtt5_packet_id_t = UInt16

"""
    aws_mqtt5_payload_format_indicator

Optional property describing a message's payload format. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901063
"""
@cenum aws_mqtt5_payload_format_indicator::UInt32 begin
    AWS_MQTT5_PFI_BYTES = 0
    AWS_MQTT5_PFI_UTF8 = 1
end

"""
    aws_mqtt5_packet_publish_view

Read-only snapshot of a PUBLISH packet. Used both in configuration of a publish operation and callback data in message receipt.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901100
"""
struct aws_mqtt5_packet_publish_view
    payload::aws_byte_cursor
    packet_id::aws_mqtt5_packet_id_t
    qos::aws_mqtt5_qos
    duplicate::Bool
    retain::Bool
    topic::aws_byte_cursor
    payload_format::Ptr{aws_mqtt5_payload_format_indicator}
    message_expiry_interval_seconds::Ptr{UInt32}
    topic_alias::Ptr{UInt16}
    response_topic::Ptr{aws_byte_cursor}
    correlation_data::Ptr{aws_byte_cursor}
    subscription_identifier_count::Csize_t
    subscription_identifiers::Ptr{UInt32}
    content_type::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
end

"""
    aws_mqtt5_packet_connect_view

Read-only snapshot of a CONNECT packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901033
"""
struct aws_mqtt5_packet_connect_view
    keep_alive_interval_seconds::UInt16
    client_id::aws_byte_cursor
    username::Ptr{aws_byte_cursor}
    password::Ptr{aws_byte_cursor}
    clean_start::Bool
    session_expiry_interval_seconds::Ptr{UInt32}
    request_response_information::Ptr{UInt8}
    request_problem_information::Ptr{UInt8}
    receive_maximum::Ptr{UInt16}
    topic_alias_maximum::Ptr{UInt16}
    maximum_packet_size_bytes::Ptr{UInt32}
    will_delay_interval_seconds::Ptr{UInt32}
    will::Ptr{aws_mqtt5_packet_publish_view}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
    authentication_method::Ptr{aws_byte_cursor}
    authentication_data::Ptr{aws_byte_cursor}
end

"""
    aws_mqtt5_client_options

Basic mqtt5 client configuration struct.

Contains desired connection properties Configuration that represents properties of the mqtt5 CONNECT packet go in the connect view (connect\\_options)
"""
struct aws_mqtt5_client_options
    host_name::aws_byte_cursor
    port::UInt32
    bootstrap::Ptr{aws_client_bootstrap}
    socket_options::Ptr{aws_socket_options}
    tls_options::Ptr{aws_tls_connection_options}
    http_proxy_options::Ptr{aws_http_proxy_options}
    websocket_handshake_transform::Ptr{aws_mqtt5_transform_websocket_handshake_fn}
    websocket_handshake_transform_user_data::Ptr{Cvoid}
    connect_options::Ptr{aws_mqtt5_packet_connect_view}
    session_behavior::aws_mqtt5_client_session_behavior_type
    extended_validation_and_flow_control_options::aws_mqtt5_extended_validation_and_flow_control_options
    offline_queue_behavior::aws_mqtt5_client_operation_queue_behavior_type
    retry_jitter_mode::aws_exponential_backoff_jitter_mode
    min_reconnect_delay_ms::UInt64
    max_reconnect_delay_ms::UInt64
    min_connected_time_to_reset_reconnect_delay_ms::UInt64
    ping_timeout_ms::UInt32
    connack_timeout_ms::UInt32
    ack_timeout_seconds::UInt32
    topic_aliasing_options::Ptr{aws_mqtt5_client_topic_alias_options}
    publish_received_handler::Ptr{aws_mqtt5_publish_received_fn}
    publish_received_handler_user_data::Ptr{Cvoid}
    lifecycle_event_handler::Ptr{aws_mqtt5_client_connection_event_callback_fn}
    lifecycle_event_handler_user_data::Ptr{Cvoid}
    client_termination_handler::Ptr{aws_mqtt5_client_termination_completion_fn}
    client_termination_handler_user_data::Ptr{Cvoid}
    host_resolution_override::Ptr{aws_host_resolution_config}
end

"""
    aws_mqtt5_client_new(allocator, options)

Creates a new mqtt5 client using the supplied configuration

# Arguments
* `allocator`: allocator to use with all memory operations related to this client's creation and operation
* `options`: mqtt5 client configuration
# Returns
a new mqtt5 client or NULL
### Prototype
```c
struct aws_mqtt5_client *aws_mqtt5_client_new( struct aws_allocator *allocator, const struct aws_mqtt5_client_options *options);
```
"""
function aws_mqtt5_client_new(allocator, options)
    ccall((:aws_mqtt5_client_new, libaws_c_mqtt), Ptr{aws_mqtt5_client}, (Ptr{aws_allocator}, Ptr{aws_mqtt5_client_options}), allocator, options)
end

"""
    aws_mqtt5_client_acquire(client)

Acquires a reference to an mqtt5 client

# Arguments
* `client`: client to acquire a reference to. May be NULL.
# Returns
what was passed in as the client (a client or NULL)
### Prototype
```c
struct aws_mqtt5_client *aws_mqtt5_client_acquire(struct aws_mqtt5_client *client);
```
"""
function aws_mqtt5_client_acquire(client)
    ccall((:aws_mqtt5_client_acquire, libaws_c_mqtt), Ptr{aws_mqtt5_client}, (Ptr{aws_mqtt5_client},), client)
end

"""
    aws_mqtt5_client_release(client)

Release a reference to an mqtt5 client. When the client ref count drops to zero, the client will automatically trigger a stop and once the stop completes, the client will delete itself.

# Arguments
* `client`: client to release a reference to. May be NULL.
# Returns
NULL
### Prototype
```c
struct aws_mqtt5_client *aws_mqtt5_client_release(struct aws_mqtt5_client *client);
```
"""
function aws_mqtt5_client_release(client)
    ccall((:aws_mqtt5_client_release, libaws_c_mqtt), Ptr{aws_mqtt5_client}, (Ptr{aws_mqtt5_client},), client)
end

"""
    aws_mqtt5_client_start(client)

Asynchronous notify to the mqtt5 client that you want it to attempt to connect to the configured endpoint. The client will attempt to stay connected using the properties of the reconnect-related parameters in the mqtt5 client configuration.

# Arguments
* `client`: mqtt5 client to start
# Returns
success/failure in the synchronous logic that kicks off the start process
### Prototype
```c
int aws_mqtt5_client_start(struct aws_mqtt5_client *client);
```
"""
function aws_mqtt5_client_start(client)
    ccall((:aws_mqtt5_client_start, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_client},), client)
end

"""
    aws_mqtt5_client_stop(client, disconnect_options, completion_options)

Asynchronous notify to the mqtt5 client that you want it to transition to the stopped state. When the client reaches the stopped state, all session state is erased.

# Arguments
* `client`: mqtt5 client to stop
* `disconnect_options`: (optional) properties of a DISCONNECT packet to send as part of the shutdown process
# Returns
success/failure in the synchronous logic that kicks off the stop process
### Prototype
```c
int aws_mqtt5_client_stop( struct aws_mqtt5_client *client, const struct aws_mqtt5_packet_disconnect_view *disconnect_options, const struct aws_mqtt5_disconnect_completion_options *completion_options);
```
"""
function aws_mqtt5_client_stop(client, disconnect_options, completion_options)
    ccall((:aws_mqtt5_client_stop, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_client}, Ptr{aws_mqtt5_packet_disconnect_view}, Ptr{aws_mqtt5_disconnect_completion_options}), client, disconnect_options, completion_options)
end

"""
    aws_mqtt5_client_publish(client, publish_options, completion_options)

Queues a Publish operation in an mqtt5 client

# Arguments
* `client`: mqtt5 client to queue a Publish for
* `publish_options`: configuration options for the Publish operation
* `completion_options`: completion callback configuration. Successful QoS 0 publishes invoke the callback when the data has been written to the socket. Successful QoS1+ publishes invoke the callback when the corresponding ack is received. Unsuccessful publishes invoke the callback at the point in time a failure condition is reached.
# Returns
success/failure in the synchronous logic that kicks off the publish operation
### Prototype
```c
int aws_mqtt5_client_publish( struct aws_mqtt5_client *client, const struct aws_mqtt5_packet_publish_view *publish_options, const struct aws_mqtt5_publish_completion_options *completion_options);
```
"""
function aws_mqtt5_client_publish(client, publish_options, completion_options)
    ccall((:aws_mqtt5_client_publish, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_client}, Ptr{aws_mqtt5_packet_publish_view}, Ptr{aws_mqtt5_publish_completion_options}), client, publish_options, completion_options)
end

"""
    aws_mqtt5_retain_handling_type

Configures how retained messages should be handled when subscribing with a topic filter that matches topics with associated retained messages.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901169
"""
@cenum aws_mqtt5_retain_handling_type::UInt32 begin
    AWS_MQTT5_RHT_SEND_ON_SUBSCRIBE = 0
    AWS_MQTT5_RHT_SEND_ON_SUBSCRIBE_IF_NEW = 1
    AWS_MQTT5_RHT_DONT_SEND = 2
end

"""
    aws_mqtt5_subscription_view

Configures a single subscription within a Subscribe operation
"""
struct aws_mqtt5_subscription_view
    topic_filter::aws_byte_cursor
    qos::aws_mqtt5_qos
    no_local::Bool
    retain_as_published::Bool
    retain_handling_type::aws_mqtt5_retain_handling_type
end

"""
    aws_mqtt5_packet_subscribe_view

Read-only snapshot of a SUBSCRIBE packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901161
"""
struct aws_mqtt5_packet_subscribe_view
    packet_id::aws_mqtt5_packet_id_t
    subscription_count::Csize_t
    subscriptions::Ptr{aws_mqtt5_subscription_view}
    subscription_identifier::Ptr{UInt32}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
end

"""
    aws_mqtt5_client_subscribe(client, subscribe_options, completion_options)

Queues a Subscribe operation in an mqtt5 client

# Arguments
* `client`: mqtt5 client to queue a Subscribe for
* `subscribe_options`: configuration options for the Subscribe operation
* `completion_options`: Completion callback configuration. Invoked when the corresponding SUBACK is received or a failure condition is reached. An error code implies complete failure of the subscribe, while a success code implies the user must still check all of the SUBACK's reason codes for per-subscription feedback.
# Returns
success/failure in the synchronous logic that kicks off the Subscribe operation
### Prototype
```c
int aws_mqtt5_client_subscribe( struct aws_mqtt5_client *client, const struct aws_mqtt5_packet_subscribe_view *subscribe_options, const struct aws_mqtt5_subscribe_completion_options *completion_options);
```
"""
function aws_mqtt5_client_subscribe(client, subscribe_options, completion_options)
    ccall((:aws_mqtt5_client_subscribe, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_client}, Ptr{aws_mqtt5_packet_subscribe_view}, Ptr{aws_mqtt5_subscribe_completion_options}), client, subscribe_options, completion_options)
end

"""
    aws_mqtt5_packet_unsubscribe_view

Read-only snapshot of an UNSUBSCRIBE packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901179
"""
struct aws_mqtt5_packet_unsubscribe_view
    packet_id::aws_mqtt5_packet_id_t
    topic_filter_count::Csize_t
    topic_filters::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
end

"""
    aws_mqtt5_client_unsubscribe(client, unsubscribe_options, completion_options)

Queues an Unsubscribe operation in an mqtt5 client

# Arguments
* `client`: mqtt5 client to queue an Unsubscribe for
* `unsubscribe_options`: configuration options for the Unsubscribe operation
* `completion_options`: Completion callback configuration. Invoked when the corresponding UNSUBACK is received or a failure condition is reached. An error code implies complete failure of the unsubscribe, while a success code implies the user must still check all of the UNSUBACK's reason codes for per-topic-filter feedback.
# Returns
success/failure in the synchronous logic that kicks off the Unsubscribe operation
### Prototype
```c
int aws_mqtt5_client_unsubscribe( struct aws_mqtt5_client *client, const struct aws_mqtt5_packet_unsubscribe_view *unsubscribe_options, const struct aws_mqtt5_unsubscribe_completion_options *completion_options);
```
"""
function aws_mqtt5_client_unsubscribe(client, unsubscribe_options, completion_options)
    ccall((:aws_mqtt5_client_unsubscribe, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_client}, Ptr{aws_mqtt5_packet_unsubscribe_view}, Ptr{aws_mqtt5_unsubscribe_completion_options}), client, unsubscribe_options, completion_options)
end

"""
    aws_mqtt5_client_get_stats(client, stats)

Queries the client's internal statistics for incomplete operations.

# Arguments
* `client`: client to get statistics for
* `stats`: set of incomplete operation statistics
### Prototype
```c
void aws_mqtt5_client_get_stats(struct aws_mqtt5_client *client, struct aws_mqtt5_client_operation_statistics *stats);
```
"""
function aws_mqtt5_client_get_stats(client, stats)
    ccall((:aws_mqtt5_client_get_stats, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_client}, Ptr{aws_mqtt5_client_operation_statistics}), client, stats)
end

"""
    aws_mqtt5_negotiated_settings_init(allocator, negotiated_settings, client_id)

Initializes the Client ID byte buf in negotiated settings

# Arguments
* `allocator`: allocator to use for memory allocation
* `negotiated_settings`: settings to apply client id to
* `client_id`: client id to set
### Prototype
```c
int aws_mqtt5_negotiated_settings_init( struct aws_allocator *allocator, struct aws_mqtt5_negotiated_settings *negotiated_settings, const struct aws_byte_cursor *client_id);
```
"""
function aws_mqtt5_negotiated_settings_init(allocator, negotiated_settings, client_id)
    ccall((:aws_mqtt5_negotiated_settings_init, libaws_c_mqtt), Cint, (Ptr{aws_allocator}, Ptr{aws_mqtt5_negotiated_settings}, Ptr{aws_byte_cursor}), allocator, negotiated_settings, client_id)
end

"""
    aws_mqtt5_negotiated_settings_copy(source, dest)

Makes an owning copy of a negotiated settings structure.

Used in downstream.

# Arguments
* `source`: settings to copy from
* `dest`: settings to copy into. Must be in a zeroed or initialized state because it gets clean up called on it as the first step of the copy process.
# Returns
success/failure
### Prototype
```c
int aws_mqtt5_negotiated_settings_copy( const struct aws_mqtt5_negotiated_settings *source, struct aws_mqtt5_negotiated_settings *dest);
```
"""
function aws_mqtt5_negotiated_settings_copy(source, dest)
    ccall((:aws_mqtt5_negotiated_settings_copy, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_negotiated_settings}, Ptr{aws_mqtt5_negotiated_settings}), source, dest)
end

"""
    aws_mqtt5_negotiated_settings_clean_up(negotiated_settings)

Clean up owned memory in negotiated\\_settings

# Arguments
* `negotiated_settings`: settings to clean up
### Prototype
```c
void aws_mqtt5_negotiated_settings_clean_up(struct aws_mqtt5_negotiated_settings *negotiated_settings);
```
"""
function aws_mqtt5_negotiated_settings_clean_up(negotiated_settings)
    ccall((:aws_mqtt5_negotiated_settings_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_negotiated_settings},), negotiated_settings)
end

# typedef void ( aws_mqtt5_listener_termination_completion_fn ) ( void * complete_ctx )
"""
Documentation not found.
"""
const aws_mqtt5_listener_termination_completion_fn = Cvoid

"""
    aws_mqtt5_callback_set

A record that tracks MQTT5 client callbacks which can be dynamically injected via a listener.
"""
struct aws_mqtt5_callback_set
    listener_publish_received_handler::Ptr{aws_mqtt5_listener_publish_received_fn}
    listener_publish_received_handler_user_data::Ptr{Cvoid}
    lifecycle_event_handler::Ptr{aws_mqtt5_client_connection_event_callback_fn}
    lifecycle_event_handler_user_data::Ptr{Cvoid}
end

"""
    aws_mqtt5_listener_config

Configuration options for MQTT5 listener objects.
"""
struct aws_mqtt5_listener_config
    client::Ptr{aws_mqtt5_client}
    listener_callbacks::aws_mqtt5_callback_set
    termination_callback::Ptr{aws_mqtt5_listener_termination_completion_fn}
    termination_callback_user_data::Ptr{Cvoid}
end

"""
Documentation not found.
"""
mutable struct aws_mqtt5_listener end

"""
    aws_mqtt5_listener_new(allocator, config)

Creates a new MQTT5 listener object. For as long as the listener lives, incoming publishes and lifecycle events will be forwarded to the callbacks configured on the listener.

# Arguments
* `allocator`: allocator to use
* `config`: listener configuration
# Returns
a new [`aws_mqtt5_listener`](@ref) object
### Prototype
```c
struct aws_mqtt5_listener *aws_mqtt5_listener_new( struct aws_allocator *allocator, struct aws_mqtt5_listener_config *config);
```
"""
function aws_mqtt5_listener_new(allocator, config)
    ccall((:aws_mqtt5_listener_new, libaws_c_mqtt), Ptr{aws_mqtt5_listener}, (Ptr{aws_allocator}, Ptr{aws_mqtt5_listener_config}), allocator, config)
end

"""
    aws_mqtt5_listener_acquire(listener)

Adds a reference to an mqtt5 listener.

# Arguments
* `listener`: listener to add a reference to
# Returns
the listener object
### Prototype
```c
struct aws_mqtt5_listener *aws_mqtt5_listener_acquire(struct aws_mqtt5_listener *listener);
```
"""
function aws_mqtt5_listener_acquire(listener)
    ccall((:aws_mqtt5_listener_acquire, libaws_c_mqtt), Ptr{aws_mqtt5_listener}, (Ptr{aws_mqtt5_listener},), listener)
end

"""
    aws_mqtt5_listener_release(listener)

Removes a reference to an mqtt5 listener. When the reference count drops to zero, the listener's asynchronous destruction will be started.

# Arguments
* `listener`: listener to remove a reference from
# Returns
NULL
### Prototype
```c
struct aws_mqtt5_listener *aws_mqtt5_listener_release(struct aws_mqtt5_listener *listener);
```
"""
function aws_mqtt5_listener_release(listener)
    ccall((:aws_mqtt5_listener_release, libaws_c_mqtt), Ptr{aws_mqtt5_listener}, (Ptr{aws_mqtt5_listener},), listener)
end

"""
    aws_mqtt5_user_property_set

Documentation not found.
"""
struct aws_mqtt5_user_property_set
    properties::aws_array_list
end

"""
    aws_mqtt5_packet_publish_storage

Documentation not found.
"""
struct aws_mqtt5_packet_publish_storage
    storage_view::aws_mqtt5_packet_publish_view
    payload_format::aws_mqtt5_payload_format_indicator
    message_expiry_interval_seconds::UInt32
    topic_alias::UInt16
    response_topic::aws_byte_cursor
    correlation_data::aws_byte_cursor
    content_type::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    subscription_identifiers::aws_array_list
    storage::aws_byte_buf
end

"""
    aws_mqtt5_packet_connect_storage

Documentation not found.
"""
struct aws_mqtt5_packet_connect_storage
    allocator::Ptr{aws_allocator}
    storage_view::aws_mqtt5_packet_connect_view
    username::aws_byte_cursor
    password::aws_byte_cursor
    session_expiry_interval_seconds::UInt32
    request_response_information::UInt8
    request_problem_information::UInt8
    receive_maximum::UInt16
    topic_alias_maximum::UInt16
    maximum_packet_size_bytes::UInt32
    will::Ptr{aws_mqtt5_packet_publish_storage}
    will_delay_interval_seconds::UInt32
    user_properties::aws_mqtt5_user_property_set
    authentication_method::aws_byte_cursor
    authentication_data::aws_byte_cursor
    storage::aws_byte_buf
end

"""
    aws_mqtt5_packet_connack_storage

Documentation not found.
"""
struct aws_mqtt5_packet_connack_storage
    allocator::Ptr{aws_allocator}
    storage_view::aws_mqtt5_packet_connack_view
    session_expiry_interval::UInt32
    receive_maximum::UInt16
    maximum_qos::aws_mqtt5_qos
    retain_available::Bool
    maximum_packet_size::UInt32
    assigned_client_identifier::aws_byte_cursor
    topic_alias_maximum::UInt16
    reason_string::aws_byte_cursor
    wildcard_subscriptions_available::Bool
    subscription_identifiers_available::Bool
    shared_subscriptions_available::Bool
    server_keep_alive::UInt16
    response_information::aws_byte_cursor
    server_reference::aws_byte_cursor
    authentication_method::aws_byte_cursor
    authentication_data::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    storage::aws_byte_buf
end

"""
    aws_mqtt5_suback_reason_code

Reason code inside SUBACK packet payloads. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901178
"""
@cenum aws_mqtt5_suback_reason_code::UInt32 begin
    AWS_MQTT5_SARC_GRANTED_QOS_0 = 0
    AWS_MQTT5_SARC_GRANTED_QOS_1 = 1
    AWS_MQTT5_SARC_GRANTED_QOS_2 = 2
    AWS_MQTT5_SARC_UNSPECIFIED_ERROR = 128
    AWS_MQTT5_SARC_IMPLEMENTATION_SPECIFIC_ERROR = 131
    AWS_MQTT5_SARC_NOT_AUTHORIZED = 135
    AWS_MQTT5_SARC_TOPIC_FILTER_INVALID = 143
    AWS_MQTT5_SARC_PACKET_IDENTIFIER_IN_USE = 145
    AWS_MQTT5_SARC_QUOTA_EXCEEDED = 151
    AWS_MQTT5_SARC_SHARED_SUBSCRIPTIONS_NOT_SUPPORTED = 158
    AWS_MQTT5_SARC_SUBSCRIPTION_IDENTIFIERS_NOT_SUPPORTED = 161
    AWS_MQTT5_SARC_WILDCARD_SUBSCRIPTIONS_NOT_SUPPORTED = 162
end

"""
    aws_mqtt5_packet_suback_view

Read-only snapshot of a SUBACK packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901171
"""
struct aws_mqtt5_packet_suback_view
    packet_id::aws_mqtt5_packet_id_t
    reason_string::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
    reason_code_count::Csize_t
    reason_codes::Ptr{aws_mqtt5_suback_reason_code}
end

"""
    aws_mqtt5_packet_suback_storage

Documentation not found.
"""
struct aws_mqtt5_packet_suback_storage
    allocator::Ptr{aws_allocator}
    storage_view::aws_mqtt5_packet_suback_view
    reason_string::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    reason_codes::aws_array_list
    storage::aws_byte_buf
end

"""
    aws_mqtt5_unsuback_reason_code

Reason code inside UNSUBACK packet payloads. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901194
"""
@cenum aws_mqtt5_unsuback_reason_code::UInt32 begin
    AWS_MQTT5_UARC_SUCCESS = 0
    AWS_MQTT5_UARC_NO_SUBSCRIPTION_EXISTED = 17
    AWS_MQTT5_UARC_UNSPECIFIED_ERROR = 128
    AWS_MQTT5_UARC_IMPLEMENTATION_SPECIFIC_ERROR = 131
    AWS_MQTT5_UARC_NOT_AUTHORIZED = 135
    AWS_MQTT5_UARC_TOPIC_FILTER_INVALID = 143
    AWS_MQTT5_UARC_PACKET_IDENTIFIER_IN_USE = 145
end

"""
    aws_mqtt5_packet_unsuback_view

Read-only snapshot of an UNSUBACK packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901187
"""
struct aws_mqtt5_packet_unsuback_view
    packet_id::aws_mqtt5_packet_id_t
    reason_string::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
    reason_code_count::Csize_t
    reason_codes::Ptr{aws_mqtt5_unsuback_reason_code}
end

"""
    aws_mqtt5_packet_unsuback_storage

Documentation not found.
"""
struct aws_mqtt5_packet_unsuback_storage
    allocator::Ptr{aws_allocator}
    storage_view::aws_mqtt5_packet_unsuback_view
    reason_string::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    reason_codes::aws_array_list
    storage::aws_byte_buf
end

"""
    aws_mqtt5_puback_reason_code

Reason code inside PUBACK packets. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901124
"""
@cenum aws_mqtt5_puback_reason_code::UInt32 begin
    AWS_MQTT5_PARC_SUCCESS = 0
    AWS_MQTT5_PARC_NO_MATCHING_SUBSCRIBERS = 16
    AWS_MQTT5_PARC_UNSPECIFIED_ERROR = 128
    AWS_MQTT5_PARC_IMPLEMENTATION_SPECIFIC_ERROR = 131
    AWS_MQTT5_PARC_NOT_AUTHORIZED = 135
    AWS_MQTT5_PARC_TOPIC_NAME_INVALID = 144
    AWS_MQTT5_PARC_PACKET_IDENTIFIER_IN_USE = 145
    AWS_MQTT5_PARC_QUOTA_EXCEEDED = 151
    AWS_MQTT5_PARC_PAYLOAD_FORMAT_INVALID = 153
end

"""
    aws_mqtt5_packet_puback_view

Read-only snapshot of a PUBACK packet

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901121
"""
struct aws_mqtt5_packet_puback_view
    packet_id::aws_mqtt5_packet_id_t
    reason_code::aws_mqtt5_puback_reason_code
    reason_string::Ptr{aws_byte_cursor}
    user_property_count::Csize_t
    user_properties::Ptr{aws_mqtt5_user_property}
end

"""
    aws_mqtt5_packet_puback_storage

Documentation not found.
"""
struct aws_mqtt5_packet_puback_storage
    storage_view::aws_mqtt5_packet_puback_view
    reason_string::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    storage::aws_byte_buf
end

"""
    aws_mqtt5_packet_disconnect_storage

Documentation not found.
"""
struct aws_mqtt5_packet_disconnect_storage
    storage_view::aws_mqtt5_packet_disconnect_view
    session_expiry_interval_seconds::UInt32
    reason_string::aws_byte_cursor
    user_properties::aws_mqtt5_user_property_set
    server_reference::aws_byte_cursor
    storage::aws_byte_buf
end

"""
    aws_mqtt5_packet_subscribe_storage

Documentation not found.
"""
struct aws_mqtt5_packet_subscribe_storage
    storage_view::aws_mqtt5_packet_subscribe_view
    subscription_identifier::UInt32
    subscriptions::aws_array_list
    user_properties::aws_mqtt5_user_property_set
    storage::aws_byte_buf
end

"""
    aws_mqtt5_packet_unsubscribe_storage

Documentation not found.
"""
struct aws_mqtt5_packet_unsubscribe_storage
    storage_view::aws_mqtt5_packet_unsubscribe_view
    topic_filters::aws_array_list
    user_properties::aws_mqtt5_user_property_set
    storage::aws_byte_buf
end

"""
    aws_mqtt5_user_property_set_init_with_storage(property_set, allocator, storage_buffer, property_count, properties)

Documentation not found.
### Prototype
```c
int aws_mqtt5_user_property_set_init_with_storage( struct aws_mqtt5_user_property_set *property_set, struct aws_allocator *allocator, struct aws_byte_buf *storage_buffer, size_t property_count, const struct aws_mqtt5_user_property *properties);
```
"""
function aws_mqtt5_user_property_set_init_with_storage(property_set, allocator, storage_buffer, property_count, properties)
    ccall((:aws_mqtt5_user_property_set_init_with_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_user_property_set}, Ptr{aws_allocator}, Ptr{aws_byte_buf}, Csize_t, Ptr{aws_mqtt5_user_property}), property_set, allocator, storage_buffer, property_count, properties)
end

"""
    aws_mqtt5_user_property_set_clean_up(property_set)

Documentation not found.
### Prototype
```c
void aws_mqtt5_user_property_set_clean_up(struct aws_mqtt5_user_property_set *property_set);
```
"""
function aws_mqtt5_user_property_set_clean_up(property_set)
    ccall((:aws_mqtt5_user_property_set_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_user_property_set},), property_set)
end

"""
    aws_mqtt5_user_property_set_size(property_set)

Documentation not found.
### Prototype
```c
size_t aws_mqtt5_user_property_set_size(const struct aws_mqtt5_user_property_set *property_set);
```
"""
function aws_mqtt5_user_property_set_size(property_set)
    ccall((:aws_mqtt5_user_property_set_size, libaws_c_mqtt), Csize_t, (Ptr{aws_mqtt5_user_property_set},), property_set)
end

"""
    aws_mqtt5_packet_connect_storage_init(connect_storage, allocator, connect_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_connect_storage_init( struct aws_mqtt5_packet_connect_storage *connect_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_connect_view *connect_options);
```
"""
function aws_mqtt5_packet_connect_storage_init(connect_storage, allocator, connect_options)
    ccall((:aws_mqtt5_packet_connect_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_connect_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_connect_view}), connect_storage, allocator, connect_options)
end

"""
    aws_mqtt5_packet_connect_storage_init_from_external_storage(connect_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_connect_storage_init_from_external_storage( struct aws_mqtt5_packet_connect_storage *connect_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_connect_storage_init_from_external_storage(connect_storage, allocator)
    ccall((:aws_mqtt5_packet_connect_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_connect_storage}, Ptr{aws_allocator}), connect_storage, allocator)
end

"""
    aws_mqtt5_packet_connect_storage_clean_up(connect_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_connect_storage_clean_up(struct aws_mqtt5_packet_connect_storage *connect_storage);
```
"""
function aws_mqtt5_packet_connect_storage_clean_up(connect_storage)
    ccall((:aws_mqtt5_packet_connect_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_connect_storage},), connect_storage)
end

"""
    aws_mqtt5_packet_connack_storage_init(connack_storage, allocator, connack_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_connack_storage_init( struct aws_mqtt5_packet_connack_storage *connack_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_connack_view *connack_options);
```
"""
function aws_mqtt5_packet_connack_storage_init(connack_storage, allocator, connack_options)
    ccall((:aws_mqtt5_packet_connack_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_connack_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_connack_view}), connack_storage, allocator, connack_options)
end

"""
    aws_mqtt5_packet_connack_storage_init_from_external_storage(connack_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_connack_storage_init_from_external_storage( struct aws_mqtt5_packet_connack_storage *connack_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_connack_storage_init_from_external_storage(connack_storage, allocator)
    ccall((:aws_mqtt5_packet_connack_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_connack_storage}, Ptr{aws_allocator}), connack_storage, allocator)
end

"""
    aws_mqtt5_packet_connack_storage_clean_up(connack_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_connack_storage_clean_up(struct aws_mqtt5_packet_connack_storage *connack_storage);
```
"""
function aws_mqtt5_packet_connack_storage_clean_up(connack_storage)
    ccall((:aws_mqtt5_packet_connack_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_connack_storage},), connack_storage)
end

"""
    aws_mqtt5_packet_disconnect_storage_init(disconnect_storage, allocator, disconnect_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_disconnect_storage_init( struct aws_mqtt5_packet_disconnect_storage *disconnect_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_disconnect_view *disconnect_options);
```
"""
function aws_mqtt5_packet_disconnect_storage_init(disconnect_storage, allocator, disconnect_options)
    ccall((:aws_mqtt5_packet_disconnect_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_disconnect_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_disconnect_view}), disconnect_storage, allocator, disconnect_options)
end

"""
    aws_mqtt5_packet_disconnect_storage_init_from_external_storage(disconnect_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_disconnect_storage_init_from_external_storage( struct aws_mqtt5_packet_disconnect_storage *disconnect_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_disconnect_storage_init_from_external_storage(disconnect_storage, allocator)
    ccall((:aws_mqtt5_packet_disconnect_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_disconnect_storage}, Ptr{aws_allocator}), disconnect_storage, allocator)
end

"""
    aws_mqtt5_packet_disconnect_storage_clean_up(disconnect_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_disconnect_storage_clean_up( struct aws_mqtt5_packet_disconnect_storage *disconnect_storage);
```
"""
function aws_mqtt5_packet_disconnect_storage_clean_up(disconnect_storage)
    ccall((:aws_mqtt5_packet_disconnect_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_disconnect_storage},), disconnect_storage)
end

"""
    aws_mqtt5_packet_publish_storage_init(publish_storage, allocator, publish_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_publish_storage_init( struct aws_mqtt5_packet_publish_storage *publish_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_publish_view *publish_options);
```
"""
function aws_mqtt5_packet_publish_storage_init(publish_storage, allocator, publish_options)
    ccall((:aws_mqtt5_packet_publish_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_publish_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_publish_view}), publish_storage, allocator, publish_options)
end

"""
    aws_mqtt5_packet_publish_storage_init_from_external_storage(publish_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_publish_storage_init_from_external_storage( struct aws_mqtt5_packet_publish_storage *publish_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_publish_storage_init_from_external_storage(publish_storage, allocator)
    ccall((:aws_mqtt5_packet_publish_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_publish_storage}, Ptr{aws_allocator}), publish_storage, allocator)
end

"""
    aws_mqtt5_packet_publish_storage_clean_up(publish_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_publish_storage_clean_up(struct aws_mqtt5_packet_publish_storage *publish_storage);
```
"""
function aws_mqtt5_packet_publish_storage_clean_up(publish_storage)
    ccall((:aws_mqtt5_packet_publish_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_publish_storage},), publish_storage)
end

"""
    aws_mqtt5_packet_puback_storage_init(puback_storage, allocator, puback_view)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_puback_storage_init( struct aws_mqtt5_packet_puback_storage *puback_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_puback_view *puback_view);
```
"""
function aws_mqtt5_packet_puback_storage_init(puback_storage, allocator, puback_view)
    ccall((:aws_mqtt5_packet_puback_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_puback_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_puback_view}), puback_storage, allocator, puback_view)
end

"""
    aws_mqtt5_packet_puback_storage_init_from_external_storage(puback_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_puback_storage_init_from_external_storage( struct aws_mqtt5_packet_puback_storage *puback_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_puback_storage_init_from_external_storage(puback_storage, allocator)
    ccall((:aws_mqtt5_packet_puback_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_puback_storage}, Ptr{aws_allocator}), puback_storage, allocator)
end

"""
    aws_mqtt5_packet_puback_storage_clean_up(puback_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_puback_storage_clean_up(struct aws_mqtt5_packet_puback_storage *puback_storage);
```
"""
function aws_mqtt5_packet_puback_storage_clean_up(puback_storage)
    ccall((:aws_mqtt5_packet_puback_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_puback_storage},), puback_storage)
end

"""
    aws_mqtt5_packet_subscribe_storage_init(subscribe_storage, allocator, subscribe_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_subscribe_storage_init( struct aws_mqtt5_packet_subscribe_storage *subscribe_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_subscribe_view *subscribe_options);
```
"""
function aws_mqtt5_packet_subscribe_storage_init(subscribe_storage, allocator, subscribe_options)
    ccall((:aws_mqtt5_packet_subscribe_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_subscribe_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_subscribe_view}), subscribe_storage, allocator, subscribe_options)
end

"""
    aws_mqtt5_packet_subscribe_storage_init_from_external_storage(subscribe_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_subscribe_storage_init_from_external_storage( struct aws_mqtt5_packet_subscribe_storage *subscribe_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_subscribe_storage_init_from_external_storage(subscribe_storage, allocator)
    ccall((:aws_mqtt5_packet_subscribe_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_subscribe_storage}, Ptr{aws_allocator}), subscribe_storage, allocator)
end

"""
    aws_mqtt5_packet_subscribe_storage_clean_up(subscribe_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_subscribe_storage_clean_up( struct aws_mqtt5_packet_subscribe_storage *subscribe_storage);
```
"""
function aws_mqtt5_packet_subscribe_storage_clean_up(subscribe_storage)
    ccall((:aws_mqtt5_packet_subscribe_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_subscribe_storage},), subscribe_storage)
end

"""
    aws_mqtt5_packet_suback_storage_init(suback_storage, allocator, suback_view)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_suback_storage_init( struct aws_mqtt5_packet_suback_storage *suback_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_suback_view *suback_view);
```
"""
function aws_mqtt5_packet_suback_storage_init(suback_storage, allocator, suback_view)
    ccall((:aws_mqtt5_packet_suback_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_suback_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_suback_view}), suback_storage, allocator, suback_view)
end

"""
    aws_mqtt5_packet_suback_storage_init_from_external_storage(suback_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_suback_storage_init_from_external_storage( struct aws_mqtt5_packet_suback_storage *suback_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_suback_storage_init_from_external_storage(suback_storage, allocator)
    ccall((:aws_mqtt5_packet_suback_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_suback_storage}, Ptr{aws_allocator}), suback_storage, allocator)
end

"""
    aws_mqtt5_packet_suback_storage_clean_up(suback_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_suback_storage_clean_up(struct aws_mqtt5_packet_suback_storage *suback_storage);
```
"""
function aws_mqtt5_packet_suback_storage_clean_up(suback_storage)
    ccall((:aws_mqtt5_packet_suback_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_suback_storage},), suback_storage)
end

"""
    aws_mqtt5_packet_unsubscribe_storage_init(unsubscribe_storage, allocator, unsubscribe_options)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_unsubscribe_storage_init( struct aws_mqtt5_packet_unsubscribe_storage *unsubscribe_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_unsubscribe_view *unsubscribe_options);
```
"""
function aws_mqtt5_packet_unsubscribe_storage_init(unsubscribe_storage, allocator, unsubscribe_options)
    ccall((:aws_mqtt5_packet_unsubscribe_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_unsubscribe_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_unsubscribe_view}), unsubscribe_storage, allocator, unsubscribe_options)
end

"""
    aws_mqtt5_packet_unsubscribe_storage_init_from_external_storage(unsubscribe_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_unsubscribe_storage_init_from_external_storage( struct aws_mqtt5_packet_unsubscribe_storage *unsubscribe_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_unsubscribe_storage_init_from_external_storage(unsubscribe_storage, allocator)
    ccall((:aws_mqtt5_packet_unsubscribe_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_unsubscribe_storage}, Ptr{aws_allocator}), unsubscribe_storage, allocator)
end

"""
    aws_mqtt5_packet_unsubscribe_storage_clean_up(unsubscribe_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_unsubscribe_storage_clean_up( struct aws_mqtt5_packet_unsubscribe_storage *unsubscribe_storage);
```
"""
function aws_mqtt5_packet_unsubscribe_storage_clean_up(unsubscribe_storage)
    ccall((:aws_mqtt5_packet_unsubscribe_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_unsubscribe_storage},), unsubscribe_storage)
end

"""
    aws_mqtt5_packet_unsuback_storage_init(unsuback_storage, allocator, unsuback_view)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_unsuback_storage_init( struct aws_mqtt5_packet_unsuback_storage *unsuback_storage, struct aws_allocator *allocator, const struct aws_mqtt5_packet_unsuback_view *unsuback_view);
```
"""
function aws_mqtt5_packet_unsuback_storage_init(unsuback_storage, allocator, unsuback_view)
    ccall((:aws_mqtt5_packet_unsuback_storage_init, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_unsuback_storage}, Ptr{aws_allocator}, Ptr{aws_mqtt5_packet_unsuback_view}), unsuback_storage, allocator, unsuback_view)
end

"""
    aws_mqtt5_packet_unsuback_storage_init_from_external_storage(unsuback_storage, allocator)

Documentation not found.
### Prototype
```c
int aws_mqtt5_packet_unsuback_storage_init_from_external_storage( struct aws_mqtt5_packet_unsuback_storage *unsuback_storage, struct aws_allocator *allocator);
```
"""
function aws_mqtt5_packet_unsuback_storage_init_from_external_storage(unsuback_storage, allocator)
    ccall((:aws_mqtt5_packet_unsuback_storage_init_from_external_storage, libaws_c_mqtt), Cint, (Ptr{aws_mqtt5_packet_unsuback_storage}, Ptr{aws_allocator}), unsuback_storage, allocator)
end

"""
    aws_mqtt5_packet_unsuback_storage_clean_up(unsuback_storage)

Documentation not found.
### Prototype
```c
void aws_mqtt5_packet_unsuback_storage_clean_up( struct aws_mqtt5_packet_unsuback_storage *unsuback_storage);
```
"""
function aws_mqtt5_packet_unsuback_storage_clean_up(unsuback_storage)
    ccall((:aws_mqtt5_packet_unsuback_storage_clean_up, libaws_c_mqtt), Cvoid, (Ptr{aws_mqtt5_packet_unsuback_storage},), unsuback_storage)
end

"""
    aws_mqtt5_packet_type

Type of mqtt packet. Enum values match mqtt spec encoding values.

https://docs.oasis-open.org/mqtt/mqtt/v5.0/os/mqtt-v5.0-os.html#\\_Toc3901022
"""
@cenum aws_mqtt5_packet_type::Int32 begin
    AWS_MQTT5_PT_NONE = -1
    AWS_MQTT5_PT_RESERVED = 0
    AWS_MQTT5_PT_CONNECT = 1
    AWS_MQTT5_PT_CONNACK = 2
    AWS_MQTT5_PT_PUBLISH = 3
    AWS_MQTT5_PT_PUBACK = 4
    AWS_MQTT5_PT_PUBREC = 5
    AWS_MQTT5_PT_PUBREL = 6
    AWS_MQTT5_PT_PUBCOMP = 7
    AWS_MQTT5_PT_SUBSCRIBE = 8
    AWS_MQTT5_PT_SUBACK = 9
    AWS_MQTT5_PT_UNSUBSCRIBE = 10
    AWS_MQTT5_PT_UNSUBACK = 11
    AWS_MQTT5_PT_PINGREQ = 12
    AWS_MQTT5_PT_PINGRESP = 13
    AWS_MQTT5_PT_DISCONNECT = 14
    AWS_MQTT5_PT_AUTH = 15
end

"""
Documentation not found.
"""
const AWS_C_MQTT_PACKAGE_ID = 5

"""
Documentation not found.
"""
const AWS_MQTT5_CLIENT_MAXIMUM_USER_PROPERTIES = 1024

"""
Documentation not found.
"""
const AWS_MQTT5_CLIENT_MAXIMUM_SUBSCRIPTIONS_PER_SUBSCRIBE = 1024

"""
Documentation not found.
"""
const AWS_MQTT5_CLIENT_MAXIMUM_TOPIC_FILTERS_PER_UNSUBSCRIBE = 1024

