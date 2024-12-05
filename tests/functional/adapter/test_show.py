from dbt.tests.adapter.dbt_show.test_dbt_show import (
    BaseShowLimit,
    BaseShowSqlHeader,
    BaseShowDoesNotHandleDoubleLimit,
)


class TestGaussDBDWSShowSqlHeader(BaseShowSqlHeader):
    pass


class TestGaussDBDWSShowLimit(BaseShowLimit):
    pass


class TestGaussDBDWSShowDoesNotHandleDoubleLimit(BaseShowDoesNotHandleDoubleLimit):
    pass
