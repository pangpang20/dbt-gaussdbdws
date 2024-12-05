from dbt.tests.adapter.dbt_debug.test_dbt_debug import (
    BaseDebugGaussDBDWS,
    BaseDebugInvalidProjectGaussDBDWS,
)


class TestDebugPostgres(BaseDebugGaussDBDWS):
    pass


class TestDebugInvalidProjectPostgres(BaseDebugInvalidProjectGaussDBDWS):
    pass
