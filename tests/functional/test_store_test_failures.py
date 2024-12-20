import pytest

from dbt.tests.adapter.store_test_failures_tests.basic import (
    StoreTestFailuresAsExceptions,
    StoreTestFailuresAsGeneric,
    StoreTestFailuresAsInteractions,
    StoreTestFailuresAsProjectLevelEphemeral,
    StoreTestFailuresAsProjectLevelOff,
    StoreTestFailuresAsProjectLevelView,
)


class GaussDBDWSMixin:
    audit_schema: str

    @pytest.fixture(scope="function", autouse=True)
    def setup_audit_schema(self, project, setup_method):
        # gaussdbdws only supports schema names of 63 characters
        # a schema with a longer name still gets created, but the name gets truncated
        self.audit_schema = self.audit_schema[:63]


class TestStoreTestFailuresAsInteractions(StoreTestFailuresAsInteractions, GaussDBDWSMixin):
    pass


class TestStoreTestFailuresAsProjectLevelOff(StoreTestFailuresAsProjectLevelOff, GaussDBDWSMixin):
    pass


class TestStoreTestFailuresAsProjectLevelView(
    StoreTestFailuresAsProjectLevelView, GaussDBDWSMixin
):
    pass


class TestStoreTestFailuresAsProjectLevelEphemeral(
    StoreTestFailuresAsProjectLevelEphemeral, GaussDBDWSMixin
):
    pass


class TestStoreTestFailuresAsGeneric(StoreTestFailuresAsGeneric, GaussDBDWSMixin):
    pass


class TestStoreTestFailuresAsExceptions(StoreTestFailuresAsExceptions, GaussDBDWSMixin):
    pass
