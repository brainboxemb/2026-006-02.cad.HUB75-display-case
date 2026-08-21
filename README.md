# HUB75 Display Case

> The model and documentation were developed with the assistance of ChatGPT.


OpenSCAD design for a wooden HUB75 display case. Version **1.0** preserves the original display-case design direction. The later slim-case / roundwood-frame concept is reserved for **v1.1** and is intentionally kept separate.

## Project status

**Project status:** Concept development  
Version **v1.0** captures the original HUB75 display-case concept and is mainly retained as a reference design. It combines a wooden case with an aluminium HUB75 subframe, removable panels, printed mounting parts and integrated carrying features. This version has not yet been validated as a final fabrication design. Further development of the alternative slim-case concept will continue separately as **v1.1**.


## Version 1.0

Version 1.0 contains the original concept with:

- 15 mm plywood structural frame;
- oak front trim and acrylic front panel;
- lower storage compartment;
- removable front/ground panel;
- aluminium HUB75 subframe and LED-panel references;
- side clamps and printed clamp interfaces;
- top handle and corner handle parts;
- printed lower corner brackets and rubber-foot references.

## Repository layout

```text
.
├── README.md
├── cad/
│   └── v1.0/
│       ├── main.scad
│       ├── config/
│       ├── components/
│       ├── assemblies/
│       └── render/
│           ├── front.scad
│           ├── rear.scad
│           ├── front_angled.scad
│           ├── rear_angled.scad
│           ├── exploded_front.scad
│           └── exploded_rear.scad
└── out/
    └── v1.0/
        └── png/
```

## OpenSCAD

Open `cad/v1.0/main.scad` for the complete model and Customizer. Individual files in `components/` and `assemblies/` can also be opened for component-level work.

## Documentation renders

The `.scad` files in `cad/v1.0/render/` are dedicated documentation views. The render automation can discover these files and generate the corresponding PNG files in `out/v1.0/png/`.

### Front and rear

| Front | Rear |
| --- | --- |
| ![Front view](out/v1.0/png/hub75-display-case-front.png) | ![Rear view](out/v1.0/png/hub75-display-case-rear.png) |

The rear documentation view shows the case from the rear with the removable rear panel omitted so the internal construction remains visible.

### Angled views

| Front angled | Rear angled |
| --- | --- |
| ![Front angled view](out/v1.0/png/hub75-display-case-front-angled.png) | ![Rear angled view](out/v1.0/png/hub75-display-case-rear-angled.png) |

### Exploded views

| Exploded front | Exploded rear |
| --- | --- |
| ![Exploded front view](out/v1.0/png/hub75-display-case-exploded-front.png) | ![Exploded rear view](out/v1.0/png/hub75-display-case-exploded-rear.png) |

The images above are generated artifacts. They do not need to be edited manually; changes to the corresponding files in `cad/v1.0/render/` define the documented camera views.

## v1.1

The alternative slim upper case with the external roundwood carry structure is reserved for **v1.1**. It explores a substantially different structural direction and is therefore intentionally not mixed into the v1.0 model.

Keeping both versions separate makes **v1.0 a stable reference for the original concept**, while v1.1 can develop independently when work on that concept resumes.
