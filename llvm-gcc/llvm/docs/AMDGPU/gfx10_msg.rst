..
    **************************************************
    *                                                *
    *   Automatically generated file, do not edit!   *
    *                                                *
    **************************************************

.. _amdgpu_synid10_msg:

msg
===========================

A 16-bit message code. The bits of this operand have the following meaning:

    ============ =============================== ===============
    Bits         Description                     Value Range
    ============ =============================== ===============
    3:0          Message *type*.                 0..15
    6:4          Optional *operation*.           0..7
    7:7          Unused.                         \-
    9:8          Optional *stream*.              0..3
    15:10        Unused.                         \-
    ============ =============================== ===============

This operand may be specified as one of the following:

* An :ref:`integer_number<amdgpu_synid_integer_number>` or an :ref:`absolute_expression<amdgpu_synid_absolute_expression>`. The value must be in the range 0..0xFFFF.
* A *sendmsg* value described below.

    ==================================== ====================================================
    Sendmsg Value Syntax                 Description
    ==================================== ====================================================
    sendmsg(<*type*>)                    A message identified by its *type*.
    sendmsg(<*type*>,<*op*>)             A message identified by its *type* and *operation*.
    sendmsg(<*type*>,<*op*>,<*stream*>)  A message identified by its *type* and *operation*
                                         with a stream *id*.
    ==================================== ====================================================

*Type* may be specified using message *name* or message *id*.

*Op* may be specified using operation *name* or operation *id*.

Stream *id* is an integer in the range 0..3.

Numeric values may be specified as positive :ref:`integer numbers<amdgpu_synid_integer_number>`
or :ref:`absolute expressions<amdgpu_synid_absolute_expression>`.

Each message type supports specific operations:

    =================== ========== ============================== ============ ==========
    Message name        Message Id Supported Operations           Operation Id Stream Id
    =================== ========== ============================== ============ ==========
    MSG_INTERRUPT       1          \-                             \-           \-
    MSG_GS              2          GS_OP_CUT                      1            Optional
    \                              GS_OP_EMIT                     2            Optional
    \                              GS_OP_EMIT_CUT                 3            Optional
    MSG_GS_DONE         3          GS_OP_NOP                      0            \-
    \                              GS_OP_CUT                      1            Optional
    \                              GS_OP_EMIT                     2            Optional
    \                              GS_OP_EMIT_CUT                 3            Optional
    MSG_SAVEWAVE        4          \-                             \-           \-
    MSG_STALL_WAVE_GEN  5          \-                             \-           \-
    MSG_HALT_WAVES      6          \-                             \-           \-
    MSG_ORDERED_PS_DONE 7          \-                             \-           \-
    MSG_GS_ALLOC_REQ    9          \-                             \-           \-
    MSG_GET_DOORBELL    10         \-                             \-           \-
    MSG_GET_DDID        11         \-                             \-           \-
    MSG_SYSMSG          15         SYSMSG_OP_ECC_ERR_INTERRUPT    1            \-
    \                              SYSMSG_OP_REG_RD               2            \-
    \                              SYSMSG_OP_HOST_TRAP_ACK        3            \-
    \                              SYSMSG_OP_TTRACE_PC            4            \-
    =================== ========== ============================== ============ ==========

*Sendmsg* arguments are validated depending on how *type* value is specified:

* If message *type* is specified by name, arguments values must satisfy limitations detailed in the table above.
* If message *type* is specified as a number, each argument must not exceed corresponding value range (see the first table).

Examples:

.. parsed-literal::

    // numeric message code
    msg = 0x10
    s_sendmsg 0x12
    s_sendmsg msg + 2

    // sendmsg with strict arguments validation
    s_sendmsg sendmsg(MSG_INTERRUPT)
    s_sendmsg sendmsg(MSG_GS, GS_OP_EMIT)
    s_sendmsg sendmsg(MSG_GS, 2)
    s_sendmsg sendmsg(MSG_GS_DONE, GS_OP_EMIT_CUT, 1)
    s_sendmsg sendmsg(MSG_SYSMSG, SYSMSG_OP_TTRACE_PC)
    s_sendmsg sendmsg(MSG_GET_DOORBELL)

    // sendmsg with validation of value range only
    msg = 2
    op = 3
    stream = 1
    s_sendmsg sendmsg(msg, op, stream)
    s_sendmsg sendmsg(2, GS_OP_CUT)

