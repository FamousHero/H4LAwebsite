/**
 * @jest-environment jsdom
 */
const {stickItHere} = require('/code/_site/assets/js/about')

describe('stickItHere function', () =>{

    let querySelectorMock;

    beforeEach(() => {
        const STICKYNAVTOP = 100;
        // Reset the scrollY value before each test
        global.scrollY = 0;

        // Mock document.querySelector to simulate getting the sticky-nav element
        querySelectorMock = jest.spyOn(document, 'querySelector').mockImplementation((selector) => {
            if (selector === '#sticky-nav') {
                return {
                    classList: {
                        add: jest.fn(),
                        remove: jest.fn(),
                }};
            }
        });
    });
    
    afterEach(() => {
        // Restore the original querySelector after each test
        querySelectorMock.mockRestore();
    });
   
    test('should add "stick-it" class when scrollY is greater than or equal to STICKYNAVTOP', () => {
        // Set scrollY to a value greater than or equal to STICKYNAVTOP
        global.scrollY = 343;

        stickItHere();

        // Check if the class "stick-it" was added to #sticky-nav
        expect(document.querySelector).toHaveBeenCalledWith("#sticky-nav");

        expect(querySelectorMock.mock.results[0].value.classList.add).toHaveBeenCalledWith('stick-it');
         
    });

    test('should remove "stick-it" class when scrollY is less than STICKYNAVTOP', () => {
        // Set scrollY to a value less than STICKYNAVTOP
        global.window.scrollY = 50;

        stickItHere();

        // Check if the class "stick-it" was removed from #sticky-nav
        expect(querySelectorMock.mock.results[0].value.classList.remove).toHaveBeenCalledWith("stick-it");
    });
});