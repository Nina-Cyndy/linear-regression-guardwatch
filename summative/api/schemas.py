from typing import Literal

from pydantic import BaseModel, Field


class PredictionRequest(BaseModel):

    location: Literal[
        "peri_urban",
        "remote",
        "rural",
        "urban"
    ]

    time_of_day: Literal[
        "dawn_dusk",
        "day",
        "night"
    ]

    day_of_week: Literal[
        "weekday",
        "weekend"
    ]

    call_type: Literal[
        "cardiac",
        "medical",
        "obstetric",
        "other",
        "pediatric",
        "trauma"
    ]

    priority: Literal[
        "p1_emergency",
        "p2_urgent",
        "p3_routine"
    ]

    caller_type: Literal[
        "bystander",
        "chw",
        "health_facility",
        "other",
        "patient_family",
        "police"
    ]

    national_number_used: Literal[0, 1]

    dispatch_center_used: Literal[0, 1]

    call_to_dispatch_min: float = Field(
        ge=1,
        le=29
    )

    ambulance_available: Literal[0, 1]

    crew_size: int = Field(
        ge=0,
        le=3
    )

    highest_qualification: Literal[
        "driver_only",
        "emt_basic",
        "emt_intermediate",
        "na",
        "nurse",
        "paramedic"
    ]

    equipment_complete: Literal[0, 1]

    oxygen_available: Literal[0, 1]

    defibrillator_available: Literal[0, 1]

    gps_tracked: Literal[0, 1]

    alternative_transport: Literal[
        "ambulance",
        "motorcycle",
        "none",
        "police",
        "private_vehicle",
        "taxi",
        "walked"
    ]

    year: int = Field(
        ge=2019,
        le=2023
    )