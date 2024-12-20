{% macro gaussdbdws__get_alter_materialized_view_as_sql(
    relation,
    configuration_changes,
    sql,
    existing_relation,
    backup_relation,
    intermediate_relation
) %}

    {% if configuration_changes.requires_full_refresh %}

        {{ get_replace_sql(existing_relation, relation, sql) }}

    {% else %}

        {{ gaussdbdws__update_indexes_on_materialized_view(relation, configuration_changes.indexes) }}

    {%- endif -%}

{% endmacro %}


{%- macro gaussdbdws__update_indexes_on_materialized_view(relation, index_changes) -%}
    {{- log("Applying UPDATE INDEXES to: " ~ relation) -}}

    {%- for _index_change in index_changes -%}
        {%- set _index = _index_change.context -%}

        {%- if _index_change.action == "drop" -%}

            {{ gaussdbdws__get_drop_index_sql(relation, _index.name) }}

        {%- elif _index_change.action == "create" -%}

            {{ gaussdbdws__get_create_index_sql(relation, _index.as_node_config) }}

        {%- endif -%}
	{{ ';' if not loop.last else "" }}

    {%- endfor -%}

{%- endmacro -%}


{% macro gaussdbdws__get_materialized_view_configuration_changes(existing_relation, new_config) %}
    {% set _existing_materialized_view = gaussdbdws__describe_materialized_view(existing_relation) %}
    {% set _configuration_changes = existing_relation.get_materialized_view_config_change_collection(_existing_materialized_view, new_config.model) %}
    {% do return(_configuration_changes) %}
{% endmacro %}
