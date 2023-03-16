resource "datadog_dashboard_json" "WEB_UI_Synthetics" {
  dashboard = <<EOF
{
    "title": "WEB UI-Synthetics Dashboard",
    "description": "",
    "widgets": [
        {
            "id": 3130834768472763,
            "definition": {
                "title": "Synthetic browser test analysis",
                "background_color": "vivid_green",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 8349759620360535,
                        "definition": {
                            "type": "image",
                            "url": "https://static.datadoghq.com/static/images/logos/chrome_avatar.svg",
                            "sizing": "contain",
                            "has_background": false,
                            "has_border": false,
                            "vertical_align": "center",
                            "horizontal_align": "center"
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 2,
                            "height": 1
                        }
                    },
                    {
                        "id": 7160841925251030,
                        "definition": {
                            "title": "Average browser test duration by location",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "auto",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "alias": "Test duration",
                                            "formula": "query1"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "queries": [
                                        {
                                            "query": "avg:synthetics.browser.test_duration{$TestID,$Browser,$Region,$RunType,$Env,$StepID} by {location}",
                                            "data_source": "metrics",
                                            "name": "query1"
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
                            "custom_links": [
                                {
                                    "override_label": "traces",
                                    "is_hidden": false,
                                    "link": "/apm/traces?query=public_id:{{$TestID.value}}&start={{timestamp_start}}&end={{timestamp_end}}&paused=true&metricQuery=true&historicalData=true"
                                },
                                {
                                    "override_label": "rum",
                                    "is_hidden": false,
                                    "link": "/rum/explorer?query=@synthetics.test_id:{{$TestID.value}}&live=false&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}"
                                },
                                {
                                    "override_label": "containers",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "hosts",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "logs",
                                    "is_hidden": true,
                                    "link": "/logs?from_ts={{timestamp_start}}&to_ts={{timestamp_end}}&query=public_id:{{$TestID.value}}"
                                },
                                {
                                    "override_label": "profiles",
                                    "is_hidden": true
                                },
                                {
                                    "link": "/synthetics/tests?query=test_id:{{$TestID.value}} type:browser region:{{location.value}}&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}",
                                    "label": "View in Synthetics"
                                }
                            ]
                        },
                        "layout": {
                            "x": 2,
                            "y": 0,
                            "width": 10,
                            "height": 3
                        }
                    },
                    {
                        "id": 8403533253145886,
                        "definition": {
                            "title": "Chrome success rate",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1 / query2 * 100"
                                        }
                                    ],
                                    "conditional_formats": [
                                        {
                                            "comparator": "<",
                                            "palette": "white_on_red",
                                            "value": 80
                                        },
                                        {
                                            "comparator": "<",
                                            "palette": "white_on_yellow",
                                            "value": 90
                                        },
                                        {
                                            "comparator": ">=",
                                            "palette": "white_on_green",
                                            "value": 90
                                        }
                                    ],
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:synthetics.test_runs{browsertype:chrome,status:success,$TestID,$Region,$RunType,$Env,$StepID,$Region,$Browser}.as_count()",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "sum"
                                        },
                                        {
                                            "query": "sum:synthetics.test_runs{browsertype:chrome,$TestID,$Region,$RunType,$Env,$StepID,$Region,$Browser}.as_count()",
                                            "data_source": "metrics",
                                            "name": "query2",
                                            "aggregator": "sum"
                                        }
                                    ]
                                }
                            ],
                            "autoscale": true,
                            "custom_unit": "%",
                            "custom_links": [
                                {
                                    "override_label": "containers",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "hosts",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "logs",
                                    "is_hidden": true,
                                    "link": "/logs?from_ts={{timestamp_start}}&to_ts={{timestamp_end}}&query=public_id:{{$TestID.value}}"
                                },
                                {
                                    "override_label": "traces",
                                    "is_hidden": false,
                                    "link": "/apm/traces?query=public_id:{{$TestID.value}}&start={{timestamp_start}}&end={{timestamp_end}}&paused=true&metricQuery=true&historicalData=true"
                                },
                                {
                                    "override_label": "profiles",
                                    "is_hidden": true
                                },
                                {
                                    "link": "/synthetics/tests?query=test_id:{{$TestID.value}} type:browser&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}",
                                    "label": "View in Synthetics"
                                }
                            ],
                            "precision": 1,
                            "timeseries_background": {
                                "type": "area",
                                "yaxis": {
                                    "include_zero": false
                                }
                            }
                        },
                        "layout": {
                            "x": 0,
                            "y": 1,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 3291920515826839,
                        "definition": {
                            "title": " Steps duration",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "vertical",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "queries": [
                                        {
                                            "query": "max:synthetics.browser.step.duration{$TestID,$StepID,$Browser} by {step_id}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        }
                                    ],
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 3,
                            "width": 12,
                            "height": 3
                        }
                    },
                    {
                        "id": 3302635181465988,
                        "definition": {
                            "title": "Step duration {$StepID}",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "vertical",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "queries": [
                                        {
                                            "query": "max:synthetics.browser.step.duration{$TestID,$StepID,$Browser}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        }
                                    ],
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "bars"
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 6,
                            "width": 12,
                            "height": 3
                        }
                    },
                    {
                        "id": 8302962511300562,
                        "definition": {
                            "title": "Test duration",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "vertical",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "queries": [
                                        {
                                            "query": "max:synthetics.browser.test_duration{$TestID}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        }
                                    ],
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 9,
                            "width": 12,
                            "height": 3
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 0,
                "width": 12,
                "height": 1
            }
        },
        {
            "id": 7762527032724655,
            "definition": {
                "title": "Synthetic test web performance",
                "background_color": "vivid_purple",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 5376643378953680,
                        "definition": {
                            "type": "note",
                            "content": "Enrich your browser test resource data by setting up integration with **Datadog's Real User Monitoring (RUM) product.** [Learn more about RUM integration.](https://docs.datadoghq.com/real_user_monitoring/)\n\nIf you have RUM set up, this table displays a detailed list of all resources loading for your browser tests. To explore your resources in more detail, [check out this dashboard](/dash/integration/rum_resources).",
                            "background_color": "purple",
                            "font_size": "14",
                            "text_align": "left",
                            "vertical_align": "center",
                            "show_tick": false,
                            "tick_pos": "50%",
                            "tick_edge": "bottom",
                            "has_padding": true
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 12,
                            "height": 2
                        }
                    },
                    {
                        "id": 8677778576576410,
                        "definition": {
                            "type": "note",
                            "content": "![core web vitals](https://static.datadoghq.com/static/images/integration_dashboard/synthetics_core_web_vitals.jpeg)\n\nCore Web Vitals give you an overview of **load performance, interactivity, and visual stability** within a lab environment. Each metric comes with guidance on the range of values that translate to good user experience. Datadog recommends monitoring the **75th percentile** for these metrics. [Learn more](https://docs.datadoghq.com/real_user_monitoring/browser/monitoring_page_performance/#core-web-vitals)",
                            "background_color": "transparent",
                            "font_size": "12",
                            "text_align": "center",
                            "vertical_align": "center",
                            "show_tick": false,
                            "tick_pos": "50%",
                            "tick_edge": "left",
                            "has_padding": false
                        },
                        "layout": {
                            "x": 0,
                            "y": 2,
                            "width": 4,
                            "height": 4
                        }
                    },
                    {
                        "id": 3248899134663703,
                        "definition": {
                            "title": "Largest Contentful Paint",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "vertical",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "alias": "p75 LCP",
                                            "formula": "query2"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "on_right_yaxis": false,
                                    "queries": [
                                        {
                                            "search": {
                                                "query": "@type:view $Env @session.type:synthetics @synthetics.test_id:$TestID.value"
                                            },
                                            "data_source": "rum",
                                            "compute": {
                                                "metric": "@view.largest_contentful_paint",
                                                "aggregation": "pc75"
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
                                "include_zero": true,
                                "scale": "linear",
                                "label": "",
                                "min": "auto",
                                "max": "auto"
                            },
                            "markers": [
                                {
                                    "label": " > 4s ",
                                    "value": "y > 4000000000",
                                    "display_type": "error solid"
                                },
                                {
                                    "value": "2500000000 < y < 4000000000",
                                    "display_type": "warning solid"
                                },
                                {
                                    "value": "y < 2500000000",
                                    "display_type": "ok solid"
                                }
                            ],
                            "custom_links": [
                                {
                                    "override_label": "containers",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "hosts",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "logs",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "traces",
                                    "is_hidden": false,
                                    "link": "/apm/traces?query=public_id:{{$TestID.value}}&start={{timestamp_start}}&end={{timestamp_end}}&paused=true&metricQuery=true&historicalData=true"
                                },
                                {
                                    "override_label": "profiles",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "rum",
                                    "is_hidden": false,
                                    "link": "/rum/explorer?live=false&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}&query=type:session @session.type:synthetics @synthetics.test_id:{{$TestID.value}}"
                                },
                                {
                                    "link": "/synthetics/tests?query=test_id:{{$TestID.value}} type:browser&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}",
                                    "label": "View in Synthetics"
                                }
                            ]
                        },
                        "layout": {
                            "x": 4,
                            "y": 2,
                            "width": 4,
                            "height": 4
                        }
                    },
                    {
                        "id": 6338899093807937,
                        "definition": {
                            "title": "Cumulative Layout Shift",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": true,
                            "legend_layout": "vertical",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "alias": "p75 CLS",
                                            "formula": "query2"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "on_right_yaxis": false,
                                    "queries": [
                                        {
                                            "search": {
                                                "query": "@type:view $Env @session.type:synthetics @synthetics.test_id:$TestID.value"
                                            },
                                            "data_source": "rum",
                                            "compute": {
                                                "metric": "@view.cumulative_layout_shift",
                                                "aggregation": "pc75"
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
                                "include_zero": true,
                                "scale": "linear",
                                "label": "",
                                "min": "auto",
                                "max": "auto"
                            },
                            "markers": [
                                {
                                    "label": " > 0.25 ",
                                    "value": "y > 0.25",
                                    "display_type": "error solid"
                                },
                                {
                                    "value": "0.1 < y < 0.25",
                                    "display_type": "warning solid"
                                },
                                {
                                    "value": "y < 0.1",
                                    "display_type": "ok solid"
                                }
                            ],
                            "custom_links": [
                                {
                                    "override_label": "containers",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "hosts",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "logs",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "traces",
                                    "is_hidden": false,
                                    "link": "/apm/traces?query=public_id:{{$TestID.value}}&start={{timestamp_start}}&end={{timestamp_end}}&paused=true&metricQuery=true&historicalData=true"
                                },
                                {
                                    "override_label": "profiles",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "rum",
                                    "is_hidden": false,
                                    "link": "/rum/explorer?live=false&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}&query=type:session @session.type:synthetics @synthetics.test_id:{{$TestID.value}}"
                                },
                                {
                                    "link": "/synthetics/tests?query=test_id:{{$TestID.value}} type:browser&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}",
                                    "label": "View in Synthetics"
                                }
                            ]
                        },
                        "layout": {
                            "x": 8,
                            "y": 2,
                            "width": 4,
                            "height": 4
                        }
                    },
                    {
                        "id": 3291914630366184,
                        "definition": {
                            "title": "Browser test 3rd party providers resources",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "alias": "Median Duration",
                                            "conditional_formats": [],
                                            "cell_display_mode": "bar",
                                            "formula": "query1"
                                        },
                                        {
                                            "alias": "Median Size",
                                            "conditional_formats": [],
                                            "cell_display_mode": "bar",
                                            "formula": "query2"
                                        },
                                        {
                                            "alias": "Count",
                                            "conditional_formats": [],
                                            "limit": {
                                                "count": 50,
                                                "order": "desc"
                                            },
                                            "cell_display_mode": "bar",
                                            "formula": "query3"
                                        }
                                    ],
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "search": {
                                                "query": "@session.type:synthetics @synthetics.test_id:$TestID.value env:$Env.value @type:resource -@resource.provider.type:\"first party\""
                                            },
                                            "data_source": "rum",
                                            "compute": {
                                                "metric": "@resource.duration",
                                                "aggregation": "median"
                                            },
                                            "name": "query1",
                                            "indexes": [
                                                "*"
                                            ],
                                            "group_by": [
                                                {
                                                    "facet": "@resource.provider.name",
                                                    "sort": {
                                                        "metric": "@resource.duration",
                                                        "aggregation": "median",
                                                        "order": "desc"
                                                    },
                                                    "limit": 50
                                                }
                                            ]
                                        },
                                        {
                                            "search": {
                                                "query": "@session.type:synthetics @synthetics.test_id:$TestID.value env:$Env.value @type:resource -@resource.provider.type:\"first party\""
                                            },
                                            "data_source": "rum",
                                            "compute": {
                                                "metric": "@resource.size",
                                                "aggregation": "median"
                                            },
                                            "name": "query2",
                                            "indexes": [
                                                "*"
                                            ],
                                            "group_by": [
                                                {
                                                    "facet": "@resource.provider.name",
                                                    "sort": {
                                                        "metric": "@resource.size",
                                                        "aggregation": "median",
                                                        "order": "desc"
                                                    },
                                                    "limit": 50
                                                }
                                            ]
                                        },
                                        {
                                            "search": {
                                                "query": "@session.type:synthetics @synthetics.test_id:$TestID.value env:$Env.value @type:resource -@resource.provider.type:\"first party\""
                                            },
                                            "data_source": "rum",
                                            "compute": {
                                                "aggregation": "count"
                                            },
                                            "name": "query3",
                                            "indexes": [
                                                "*"
                                            ],
                                            "group_by": [
                                                {
                                                    "facet": "@resource.provider.name",
                                                    "sort": {
                                                        "aggregation": "count",
                                                        "order": "desc"
                                                    },
                                                    "limit": 50
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto",
                            "custom_links": [
                                {
                                    "override_label": "containers",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "hosts",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "logs",
                                    "is_hidden": true,
                                    "link": "/logs?live=false&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}&query=public_id:{{$TestID.value}}"
                                },
                                {
                                    "override_label": "traces",
                                    "is_hidden": false,
                                    "link": "/apm/traces?query=public_id:{{$TestID.value}}&start={{timestamp_start}}&end={{timestamp_end}}&paused=true&metricQuery=true&historicalData=true"
                                },
                                {
                                    "override_label": "profiles",
                                    "is_hidden": true
                                },
                                {
                                    "override_label": "rum",
                                    "is_hidden": false,
                                    "link": "/rum/explorer?query=@type:resource @synthetics.test_id:{{$TestID.value}} @session.type:synthetics @resource.provider.name:{{@resource.provider.name.value}}&agg_m=@resource.duration&agg_q=@resource.provider.name&agg_t=avg&top_n=1000&viz=query_table&live=false&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}"
                                },
                                {
                                    "link": "/synthetics/tests?query=test_id:{{$TestID.value}} type:browser&from_ts={{timestamp_start}}&to_ts={{timestamp_end}}",
                                    "label": "View in Synthetics"
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 6,
                            "width": 12,
                            "height": 5
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 1,
                "width": 12,
                "height": 1,
                "is_column_break": true
            }
        },
        {
            "id": 5693051760566394,
            "definition": {
                "title": "Synthetic API test",
                "background_color": "vivid_pink",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 3703762249235339,
                        "definition": {
                            "title": "Response time (Max) ",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": false,
                            "legend_layout": "auto",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "name": "query1",
                                            "data_source": "metrics",
                                            "query": "max:synthetics.http.response.time{cirrus_prd:wn,check_id:$TestID.value} by {check_id}"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "bars"
                                }
                            ],
                            "custom_links": [
                                {
                                    "label": "Review Synthetics test {{check_id}}",
                                    "link": "https://app.datadoghq.com/synthetics/details/{{check_id}}"
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 4,
                            "height": 2
                        }
                    },
                    {
                        "id": 8911147869031857,
                        "definition": {
                            "title": "Response size (bytes)",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": false,
                            "legend_layout": "auto",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "name": "query1",
                                            "data_source": "metrics",
                                            "query": "avg:synthetics.http.response.size{cirrus_prd:wn,check_id:$Env.value} by {check_id}"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ]
                        },
                        "layout": {
                            "x": 4,
                            "y": 0,
                            "width": 4,
                            "height": 2
                        }
                    },
                    {
                        "id": 8165465234538402,
                        "definition": {
                            "title": "Conection type (time to establish the TCP connection to the server)",
                            "title_size": "16",
                            "title_align": "left",
                            "show_legend": false,
                            "legend_layout": "auto",
                            "legend_columns": [
                                "avg",
                                "min",
                                "max",
                                "value",
                                "sum"
                            ],
                            "type": "timeseries",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query1"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "name": "query1",
                                            "data_source": "metrics",
                                            "query": "avg:synthetics.http.connect.time{cirrus_prd:wn,check_id:$Env.value} by {check_id}"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ]
                        },
                        "layout": {
                            "x": 8,
                            "y": 0,
                            "width": 4,
                            "height": 2
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 2,
                "width": 12,
                "height": 3
            }
        }
    ],
    "template_variables": [
        {
            "name": "Browser",
            "prefix": "browsertype",
            "available_values": [
                "chrome"
            ],
            "default": "chrome"
        },
        {
            "name": "TestID",
            "prefix": "check_id",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "StepID",
            "prefix": "step_id",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "RunType",
            "prefix": "run_type",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "Env",
            "prefix": "env",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "Region",
            "prefix": "region",
            "available_values": [],
            "default": "*"
        }
    ],
    "layout_type": "ordered",
    "notify_list": [],
    "reflow_type": "fixed",
    "id": "a2y-3ij-5ed"
}
EOF
}
