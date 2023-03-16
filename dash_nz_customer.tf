# Example Dashboard JSON
#solo descarga el dashboard en json y sustituyelo
resource "datadog_dashboard_json" "NZ_Customer_Experience_Synthetics_RUM" {
  dashboard = <<EOF
{
    "title": "[NZ Prod] Customer Experience (Synthetics) (RUM)",
    "description": "",
    "widgets": [
        {
            "id": 4456855104205798,
            "definition": {
                "title": "Total user sessions",
                "title_size": "16",
                "title_align": "left",
                "type": "query_value",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "search": {
                                    "query": "@session.type:user @type:session"
                                },
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "count"
                                },
                                "group_by": []
                            }
                        ],
                        "formulas": [
                            {
                                "formula": "query1"
                            }
                        ]
                    }
                ],
                "autoscale": true,
                "precision": 2
            },
            "layout": {
                "x": 0,
                "y": 0,
                "width": 2,
                "height": 1
            }
        },
        {
            "id": 5971898664166776,
            "definition": {
                "title": "Session duration",
                "show_legend": true,
                "legend_size": "0",
                "legend_layout": "vertical",
                "legend_columns": [
                    "avg",
                    "value"
                ],
                "type": "timeseries",
                "requests": [
                    {
                        "formulas": [
                            {
                                "formula": "query2",
                                "alias": "Average session duration"
                            }
                        ],
                        "response_format": "timeseries",
                        "queries": [
                            {
                                "search": {
                                    "query": "@session.type:user"
                                },
                                "data_source": "rum",
                                "compute": {
                                    "metric": "@session.time_spent",
                                    "aggregation": "avg"
                                },
                                "name": "query2",
                                "indexes": [
                                    "*"
                                ],
                                "group_by": []
                            }
                        ],
                        "style": {
                            "palette": "dog_classic",
                            "line_type": "solid",
                            "line_width": "normal"
                        },
                        "display_type": "line"
                    }
                ],
                "yaxis": {
                    "scale": "linear",
                    "label": "",
                    "include_zero": true,
                    "min": "auto",
                    "max": "auto"
                },
                "markers": []
            },
            "layout": {
                "x": 2,
                "y": 0,
                "width": 4,
                "height": 2
            }
        },
        {
            "id": 8069287334695320,
            "definition": {
                "title": "Number of sessions by country",
                "title_size": "16",
                "title_align": "left",
                "type": "geomap",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "count"
                                },
                                "search": {
                                    "query": "@type:session @session.type:user"
                                },
                                "group_by": [
                                    {
                                        "facet": "@geo.country_iso_code",
                                        "limit": 250,
                                        "sort": {
                                            "aggregation": "count",
                                            "order": "desc"
                                        }
                                    }
                                ]
                            }
                        ],
                        "formulas": [
                            {
                                "formula": "query1",
                                "limit": {
                                    "count": 250,
                                    "order": "desc"
                                }
                            }
                        ]
                    }
                ],
                "style": {
                    "palette": "hostmap_blues",
                    "palette_flip": false
                },
                "view": {
                    "focus": "WORLD"
                }
            },
            "layout": {
                "x": 6,
                "y": 0,
                "width": 4,
                "height": 4
            }
        },
        {
            "id": 7323519429555820,
            "definition": {
                "title": "Top 10 countries",
                "type": "toplist",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "count"
                                },
                                "search": {
                                    "query": "@type:session @session.type:user"
                                },
                                "group_by": [
                                    {
                                        "facet": "@geo.country",
                                        "limit": 10,
                                        "sort": {
                                            "aggregation": "count",
                                            "order": "desc"
                                        }
                                    }
                                ]
                            }
                        ],
                        "formulas": [
                            {
                                "formula": "query1",
                                "limit": {
                                    "count": 10,
                                    "order": "desc"
                                }
                            }
                        ]
                    }
                ]
            },
            "layout": {
                "x": 10,
                "y": 0,
                "width": 2,
                "height": 4
            }
        },
        {
            "id": 7507287850870440,
            "definition": {
                "title": "Page views per session",
                "title_size": "16",
                "title_align": "left",
                "type": "query_value",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "avg",
                                    "metric": "@session.view.count"
                                },
                                "search": {
                                    "query": "@type:session @session.type:user"
                                },
                                "group_by": []
                            }
                        ]
                    }
                ],
                "autoscale": true,
                "precision": 2
            },
            "layout": {
                "x": 0,
                "y": 1,
                "width": 2,
                "height": 1
            }
        },
        {
            "id": 6627044876296320,
            "definition": {
                "title": "Average session duration",
                "title_size": "16",
                "title_align": "left",
                "type": "query_value",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "avg",
                                    "metric": "@session.time_spent"
                                },
                                "search": {
                                    "query": "@type:session @session.type:user"
                                },
                                "group_by": []
                            }
                        ]
                    }
                ],
                "autoscale": true,
                "precision": 2
            },
            "layout": {
                "x": 0,
                "y": 2,
                "width": 2,
                "height": 1
            }
        },
        {
            "id": 1251113915909272,
            "definition": {
                "title": "Pages views per session",
                "show_legend": true,
                "legend_size": "0",
                "legend_layout": "vertical",
                "legend_columns": [
                    "avg",
                    "value"
                ],
                "type": "timeseries",
                "requests": [
                    {
                        "formulas": [
                            {
                                "formula": "query2",
                                "alias": "Average number of page views"
                            }
                        ],
                        "response_format": "timeseries",
                        "queries": [
                            {
                                "search": {
                                    "query": "@session.type:user"
                                },
                                "data_source": "rum",
                                "compute": {
                                    "metric": "@session.view.count",
                                    "aggregation": "avg"
                                },
                                "name": "query2",
                                "indexes": [
                                    "*"
                                ],
                                "group_by": []
                            }
                        ],
                        "style": {
                            "palette": "dog_classic",
                            "line_type": "solid",
                            "line_width": "normal"
                        },
                        "display_type": "line"
                    }
                ],
                "yaxis": {
                    "scale": "linear",
                    "label": "",
                    "include_zero": true,
                    "min": "auto",
                    "max": "auto"
                },
                "markers": []
            },
            "layout": {
                "x": 2,
                "y": 2,
                "width": 4,
                "height": 2
            }
        },
        {
            "id": 216131940504764,
            "definition": {
                "title": "Synthetic_test_status",
                "title_size": "16",
                "title_align": "left",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "name": "query1",
                                "data_source": "metrics",
                                "query": "sum:synthetics.test_runs{client:nz} by {status}.as_count()",
                                "aggregator": "sum"
                            }
                        ],
                        "formulas": [
                            {
                                "formula": "query1"
                            }
                        ],
                        "style": {
                            "palette": "datadog16"
                        }
                    }
                ],
                "type": "sunburst",
                "legend": {
                    "type": "table"
                }
            },
            "layout": {
                "x": 0,
                "y": 3,
                "width": 2,
                "height": 3
            }
        },
        {
            "id": 8173386528083360,
            "definition": {
                "title": "Actions per session",
                "show_legend": true,
                "legend_size": "0",
                "legend_layout": "vertical",
                "legend_columns": [
                    "avg",
                    "value"
                ],
                "type": "timeseries",
                "requests": [
                    {
                        "formulas": [
                            {
                                "formula": "query2",
                                "alias": "Average number of actions"
                            }
                        ],
                        "response_format": "timeseries",
                        "on_right_yaxis": false,
                        "queries": [
                            {
                                "search": {
                                    "query": "@session.type:user"
                                },
                                "data_source": "rum",
                                "compute": {
                                    "metric": "@session.action.count",
                                    "aggregation": "avg"
                                },
                                "name": "query2",
                                "indexes": [
                                    "*"
                                ],
                                "group_by": []
                            }
                        ],
                        "style": {
                            "palette": "purple",
                            "line_type": "solid",
                            "line_width": "normal"
                        },
                        "display_type": "line"
                    }
                ],
                "yaxis": {
                    "scale": "linear",
                    "label": "",
                    "include_zero": true,
                    "min": "auto",
                    "max": "auto"
                },
                "markers": [],
                "custom_links": [
                    {
                        "link": "/rum/explorer?tab=action",
                        "label": "View RUM actions"
                    }
                ]
            },
            "layout": {
                "x": 2,
                "y": 4,
                "width": 4,
                "height": 2
            }
        },
        {
            "id": 2847242841195654,
            "definition": {
                "title": "",
                "title_size": "16",
                "title_align": "left",
                "type": "query_table",
                "requests": [
                    {
                        "response_format": "scalar",
                        "queries": [
                            {
                                "data_source": "rum",
                                "name": "query1",
                                "search": {
                                    "query": "@application.id:98f814a6-dc4c-443f-ae80-1c7010af214b @session.type:user env:production @type:resource @resource.status_code:>=400"
                                },
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "cardinality",
                                    "metric": "@session.id"
                                },
                                "group_by": [
                                    {
                                        "facet": "@resource.url_path_group",
                                        "limit": 25,
                                        "sort": {
                                            "order": "desc",
                                            "aggregation": "cardinality",
                                            "metric": "@session.id"
                                        }
                                    }
                                ]
                            },
                            {
                                "data_source": "rum",
                                "name": "query2",
                                "search": {
                                    "query": "@application.id:98f814a6-dc4c-443f-ae80-1c7010af214b @session.type:user env:production @type:resource @resource.status_code:>=400"
                                },
                                "indexes": [
                                    "*"
                                ],
                                "compute": {
                                    "aggregation": "count"
                                },
                                "group_by": [
                                    {
                                        "facet": "@resource.url_path_group",
                                        "limit": 25,
                                        "sort": {
                                            "order": "desc",
                                            "aggregation": "cardinality",
                                            "metric": "@session.id"
                                        }
                                    }
                                ]
                            }
                        ],
                        "formulas": [
                            {
                                "cell_display_mode": "bar",
                                "alias": "Total Sessions",
                                "formula": "query1",
                                "limit": {
                                    "order": "desc",
                                    "count": 25
                                }
                            },
                            {
                                "cell_display_mode": "bar",
                                "conditional_formats": [
                                    {
                                        "palette": "red_on_white",
                                        "value": 0,
                                        "comparator": ">"
                                    }
                                ],
                                "alias": "Total Errors",
                                "formula": "query2",
                                "limit": {
                                    "order": "desc",
                                    "count": 25
                                }
                            }
                        ]
                    }
                ],
                "has_search_bar": "never"
            },
            "layout": {
                "x": 6,
                "y": 4,
                "width": 3,
                "height": 2
            }
        },
        {
            "id": 4824800110892342,
            "definition": {
                "title": "Errors per session",
                "show_legend": true,
                "legend_size": "0",
                "legend_layout": "vertical",
                "legend_columns": [
                    "avg",
                    "value"
                ],
                "type": "timeseries",
                "requests": [
                    {
                        "formulas": [
                            {
                                "formula": "query2",
                                "alias": "Average number of errors"
                            }
                        ],
                        "response_format": "timeseries",
                        "on_right_yaxis": false,
                        "queries": [
                            {
                                "search": {
                                    "query": "@session.type:user"
                                },
                                "data_source": "rum",
                                "compute": {
                                    "metric": "@session.error.count",
                                    "aggregation": "avg"
                                },
                                "name": "query2",
                                "indexes": [
                                    "*"
                                ],
                                "group_by": []
                            }
                        ],
                        "style": {
                            "palette": "red",
                            "line_type": "solid",
                            "line_width": "normal"
                        },
                        "display_type": "line"
                    }
                ],
                "yaxis": {
                    "scale": "linear",
                    "label": "",
                    "include_zero": true,
                    "min": "auto",
                    "max": "auto"
                },
                "markers": [],
                "custom_links": [
                    {
                        "link": "/error-tracking",
                        "label": "View errors in Error Tracking"
                    },
                    {
                        "link": "/rum/explorer?tab=error",
                        "label": "View RUM errors"
                    },
                    {
                        "link": "/dash/integration/rum_errors",
                        "label": "Go to RUM Errors dashboard"
                    }
                ]
            },
            "layout": {
                "x": 2,
                "y": 6,
                "width": 4,
                "height": 2
            }
        }
    ],
    "template_variables": [],
    "layout_type": "ordered",
    "notify_list": [],
    "reflow_type": "fixed",
    "id": "qkz-tcj-8ts"
}
EOF
}