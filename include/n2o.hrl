-ifndef(N2O_HRL).
-define(N2O_HRL, true).

-ifdef(OTP_RELEASE).
-include_lib("kernel/include/logger.hrl").
-else.
-define(LOG_INFO(F), true).
-define(LOG_INFO(F,X), true).
-define(LOG_ERROR(F), case F of _ when is_map(F) -> io:format("{~p,~p}: ~p~n", [?MODULE,?LINE,F]); _ -> io:format(F) end).
-define(LOG_ERROR(F,X), io:format(F, M)).
-endif.

-record(handler, { name     :: atom(),
                   module   :: atom(),
                   class    :: term(),
                   group    :: atom(),
                   config   :: term(),
                   state    :: term(),
                   seq      :: term()}).

-record(pi, { name     :: atom(),
              table    :: ets:tid(),
              sup      :: atom(),
              module   :: atom(),
              state    :: term()  }).

-record(cx, { handlers  = [] :: list(#handler{}),
              actions   = [] :: list(tuple()),
              req       = [] :: [] | term(),
              module    = [] :: [] | atom(),
              lang      = [] :: [] | atom(),
              path      = [] :: [] | binary(),
              session   = [] :: [] | binary(),
              formatter = bert :: bert | json,
              params    = [] :: [] | list(tuple()),
              node      = [] :: [] | atom(),
              client_pid= [] :: [] | term(),
              state     = [] :: [] | term(),
              from      = [] :: [] | binary(),
              vsn       = [] :: [] | binary() }).

-define(CTX(ClientId), n2o:cache(ClientId)).
-define(REQ(ClientId), (n2o:cache(ClientId))#cx.req).

% API

-define(QUERING_API, [init/2, finish/2]).
-define(SESSION_API, [init/2, finish/2, get_value/2, set_value/2, clear/0]).
-define(MESSAGE_API, [send/2, reg/1, reg/2, unreg/1]).

-define(N2O_JSON, (application:get_env(n2o,json,jsone))).

% IO protocol

-record(bin,     { data=[] }).
-record(client,  { data=[] }).
-record(server,  { data=[] }).

% Nitrogen Protocol

-record(init,    { token=[] }).
-record(pickle,  { source=[], pickled=[], args=[] }).
-record(flush,   { data=[] }).
-record(direct,  { data=[] }).
-record(ev,      { module=[], msg=[], trigger=[], name=[] }).

% File Transfer Protocol

-record(ftp,     { id=[], sid=[], filename=[], meta=[], size=[], offset=[], block=[], data=[], status=[] }).
-record(ftpack,  { id=[], sid=[], filename=[], meta=[], size=[], offset=[], block=[], data=[], status=[] }).

-endif.
