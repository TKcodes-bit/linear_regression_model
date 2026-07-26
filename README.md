# Vehicle Tailpipe $CO_2$ Emission Engine Pipeline

### Mission & Problem Statement
Our mission is to combat climate change by identifying high-emission consumer vehicles using data science. This machine learning system isolates vehicular anomalies by mapping metrics like engine displacement and fuel consumption profiles. This allows tracking agencies to calculate dynamic vehicular carbon footprints instantly without needing physical testing environments.

### Public API Endpoint Engine
* **Swagger Documentation Endpoint UI:** `https://onrender.com`
* **Production Prediction Service Interface Base Route:** `https://onrender.com`

### Assignment Presentation Screen-share
* **YouTube Video Submission Link:** [Insert Production YouTube URL Link Here]

---

## Task 1: Linear Regression & Model Development Lifecycle

### 1. Unique Dataset & Source Metrics
To fulfill the strict domain requirements of this project, we explicitly rejected generic housing prices datasets. Instead, we sourced a localized automotive performance log consisting of 500 unique vehicle configurations.
* **Source:** Aggregated automobile diagnostic profiles (curated from Kaggle / Data.gov vehicle telemetry databases).
* **Target Label Variable:** `CO2_Emissions` (Continuous output integer measured in grams per kilometer ($g/km$)).
* **Independent Feature Variables:** `Engine_Size` (Liters), `Cylinders` (Count), `Fuel_Consumption_Comb` ($L/100km$), and `Transmission` (Categorical object: Manual or Automatic).

### 2. Data Visualizations & Core Interpretation
Exploratory Data Analysis (EDA) was performed via Seaborn correlation maps and scatter projections. 
* **Key Finding:** The combined fuel consumption metrics display a near-perfect linear correlation coefficient of over $+0.85$ relative to carbon outputs. 
* **Engine Dimensions Interaction:** Engine displacement sizes and cylinder counts exhibit moderate collinearity. This relationship indicates that structural changes in combustion chambers directly trigger non-trivial changes in tailpipe greenhouse outputs.

### 3. Feature Engineering & Numerical Formatting
To prepare the dataset for algebraic matrix calculations, we transformed all data into uniform numerical states:
* **Categorical Encoding:** The `Transmission` column was converted from an object string into explicit binary operational boundaries (`Manual = 0`, `Automatic = 1`).
* **Feature Pruning:** High-variance target labels were evaluated, but all primary telemetry dimensions were preserved because they each hold valid structural weight during feature importance calculations.

### 4. Mathematical Data Standardization
Because engine displacement volumes (spanning $0.5$ to $8.0$ Liters) operate on entirely different mathematical scales than cylinder counts (ranging from $2$ to $16$), raw data feeds would heavily bias gradient weights. We applied a standard Z-score calculation to scale features, ensuring that:
$$\mu = 0 \quad \text{and} \quad \sigma = 1$$
This step guarantees uniform optimization surfaces for our descent algorithms.

### 5. Gradient Descent & Multi-Algorithm Comparative Analysis
The project evaluates a Stochastic Gradient Descent (`SGDRegressor`) engine optimization routine against three distinct scikit-learn architectures using Mean Squared Error (MSE) and Coefficient of Determination ($R^2$) metrics:
* **Stochastic Gradient Descent (SGD):** Leverages an iterative optimization pathway optimized for streaming pipelines.
* **Ordinary Least Squares (OLS) Linear Regression:** Calculates direct analytical solutions via normal equations.
* **Ridge Regression:** Introduces an L2 regularization penalty ($\alpha = 1.0$) to control structural coefficient weights and prevent over-fitting.
* **Lasso Regression:** Leverages an L1 regularization penalty ($\alpha = 0.1$) to shrink less effective coefficient variables down to zero.

*Evaluation Result:* The system isolates the absolute lowest testing MSE profile, automatically preserves those pipeline parameter states, and exports the serialized weights directly to `best_regression_model.pkl` and `input_scaler.pkl`.

---

## Task 2: Robust API Architecture Implementation

### 1. Framework & Data Typing Bounds
The production service layer is managed entirely by FastAPI, utilizing Pydantic’s `BaseModel` parsing engine to strictly enforce datatype types and physical validation bounds on incoming network payloads:
* **Engine Size:** Constrained strictly between $0.5$ and $8.0$ Liters (`gte=0.5`, `lte=8.0`).
* **Cylinders:** Restricted to standard vehicular cylinder ranges from $2$ to $16$ (`gte=2`, `lte=16`).
* **Fuel Consumption:** Validated strictly between $2.0$ and $40.0$ $L/100km$ (`gte=2.0`, `lte=40.0`).
* **Transmission Numeric:** Enforced as a strict binary integer bounded between $0$ and $1$ (`gte=0`, `lte=1`).

Any submission outside these defined parameters instantly trips a $422 \text{ Unprocessable Entity}$ error to safeguard the integrity of our machine learning pipeline.

### 2. CORS Policy Logic & Security Reasoning
Cross-Origin Resource Sharing (CORS) rules are handled by the native FastAPI middleware configuration layer:
* **Allowed Scope:** Application access is intentionally decoupled via open origin access points (`allow_origins=["*"]`). This design allows cross-platform Flutter clients operating in diverse mobile runtimes (such as native Android Emulators or iOS Simulators) to establish API connections without getting blocked by browser-level cross-origin checks.
* **Restricted Scope:** Strict limits are placed on allowable HTTP verbs, locking down communication channels strictly to `POST` request interfaces for prediction and training paths. This design mitigates cross-site scripting vulnerabilities.

### 3. Dynamic Automated Model Retraining Pipeline
To ensure the system remains accurate when exposed to real-world drift, we built an active retraining pathway at `/retrain`. When streaming telemetry lists are sent to this path, the backend uses an incremental partial-fitting algorithm (`partial_fit`). This updates the internal regression model weights on the fly, saving the updated weights to the cloud platform without causing system downtime.

---

## Task 3: Cross-Platform Native Flutter Application

The client-facing frontend is a modern single-page Flutter layout designed to balance native structural presentation with clean text alignment.

### 1. Interface & Dynamic Form Inputs
The interface avoids cluttered structures by grouping elements sequentially:
* **Four Dedicated Input Forms:** Fitted with custom numeric input fields mapped directly to our engine telemetry needs.
* **Smart UI Pre-Validation:** The mobile client intercepts out-of-bounds user entries locally before wasting network resources, alerting users instantly if data falls outside proper parameters.

### 2. Execution Actions & Error States
* **The "Predict" Action Button:** Tapping this triggers an asynchronous network call that converts user inputs into structured JSON parameters.
* **State Management Layout:** A dedicated interface card sits at the bottom of the screen. It displays a loading spinner during network requests, surfaces real-world emission calculations in green when successful, and shows bold error summaries if connections time out or parameters are missing.

---

## Task 4: Video Demonstration Blueprint & Script Flow

The accompanying presentation is an explicit 7-minute technical walk-through. It requires full screen-sharing with the presenter's camera active throughout the recording.

