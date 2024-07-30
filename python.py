from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'ironhack'  # For the flash messages, not for security.

db_config = {
    'user': 'root',
    'password': 'ironhack',
    'host': 'localhost',
    'database': 'car_store'
}

@app.route('/')
def index():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT v.id, v.model, v.year, v.price, b.name AS brand_name
        FROM Vehicles v
        JOIN Brands b ON v.brand_id = b.id
    ''')
    vehicles = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('index.html', vehicles=vehicles)

@app.route('/add', methods=['GET', 'POST'])
def add_vehicle():
    if request.method == 'POST':
        brand_name = request.form['brand_name']
        model = request.form['model']
        year = request.form['year']
        price = request.form['price']
        
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.callproc('insert_vehicle_with_brand_and_details', [brand_name, model, year, price])
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('index'))
    
    return render_template('add_vehicle.html')

@app.route('/detail/<int:vehicle_id>')
def vehicle_detail(vehicle_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT v.id, v.model, v.year, v.price, b.name AS brand_name, vd.color, vd.mileage, vd.fuel_type, vd.transmission
        FROM Vehicles v
        JOIN Brands b ON v.brand_id = b.id
        JOIN VehicleDetails vd ON v.detail_id = vd.id_detail
        WHERE v.id = %s
    ''', (vehicle_id,))
    vehicle = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('vehicle_detail.html', vehicle=vehicle)

@app.route('/edit/<int:vehicle_id>', methods=['GET', 'POST'])
def edit_vehicle(vehicle_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':
        brand_name = request.form['brand_name']
        model = request.form['model']
        year = request.form['year']
        price = request.form['price']
        color = request.form['color']
        mileage = request.form['mileage']
        fuel_type = request.form['fuel_type']
        transmission = request.form['transmission']
        
        cursor.execute('SELECT id FROM Brands WHERE name = %s', (brand_name,))
        brand = cursor.fetchone()
        if brand:
            brand_id = brand['id']
        else:
            cursor.execute('INSERT INTO Brands (name) VALUES (%s)', (brand_name,))
            conn.commit()
            brand_id = cursor.lastrowid
        
        cursor.execute('''
            UPDATE Vehicles 
            SET brand_id = %s, model = %s, year = %s, price = %s
            WHERE id = %s
        ''', (brand_id, model, year, price, vehicle_id))
        
        cursor.execute('''
            UPDATE VehicleDetails 
            SET color = %s, mileage = %s, fuel_type = %s, transmission = %s
            WHERE vehicle_id = %s
        ''', (color, mileage, fuel_type, transmission, vehicle_id))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('vehicle_detail', vehicle_id=vehicle_id))
    
    cursor.execute('''
        SELECT v.id, v.model, v.year, v.price, b.name AS brand_name, vd.color, vd.mileage, vd.fuel_type, vd.transmission
        FROM Vehicles v
        JOIN Brands b ON v.brand_id = b.id
        JOIN VehicleDetails vd ON v.detail_id = vd.id_detail
        WHERE v.id = %s
    ''', (vehicle_id,))
    vehicle = cursor.fetchone()
    cursor.close()
    conn.close()
    
    return render_template('edit_vehicle.html', vehicle=vehicle)

@app.route('/delete/<int:vehicle_id>', methods=['POST'])
def delete_vehicle(vehicle_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    try:
        cursor.callproc('delete_vehicle_and_details', [vehicle_id])
        conn.commit()
        flash('Vehículo eliminado con éxito', 'success')
    except mysql.connector.Error as err:
        if err.errno == 1644:  # SQLSTATE '45000' Custom error
            flash(err.msg, 'danger')
        else:
            flash('Error al eliminar el vehículo', 'danger')
    
    cursor.close()
    conn.close()
    
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)