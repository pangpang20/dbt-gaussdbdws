import os

import pytest

from tests.functional.projects import dbt_integration


@pytest.fixture(scope="class")
def dbt_integration_project():
    return dbt_integration()


@pytest.fixture(scope="class")
def dbt_profile_target():
    return {
        "type": "gaussdbdws",
        "host": os.getenv("GAUSSDBDWS_TEST_HOST", "localhost"),
        "port": int(os.getenv("GAUSSDBDWS_TEST_PORT", 8000)),
        "user": os.getenv("GAUSSDBDWS_TEST_USER", "root"),
        "pass": os.getenv("GAUSSDBDWS_TEST_PASS", "password"),
        "dbname": os.getenv("GAUSSDBDWS_TEST_DATABASE", "dbt"),
        "threads": int(os.getenv("GAUSSDBDWS_TEST_THREADS", 4)),
    }
